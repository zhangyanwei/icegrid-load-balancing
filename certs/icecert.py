import IceCertUtils

#
# Create the certicate factory
#
factory = IceCertUtils.CertificateFactory(cn = "My CA")

# Get the CA certificate and save it to PEM/DER and JKS files
factory.getCA().save("cacert.pem").save("cacert.der").save("cacert.jks")

#
# Create a client certificate
#
client = factory.create("client", cn = "Client")

# Save the client certificate to the PKCS12 format
client.save("client.p12")

# Save the client certificate to the JKS format and also include the CA certificate in the keystore with the alias "cacert"
client.save("client.jks", caalias="cacert")

#
# Create the server certificate, include IP and DNS subject alternative names.
#
server = factory.create("server", cn = "Server", ip="127.0.0.1", dns="server.foo.com")

# Save the server certificate to the PKCS12 format
server.save("server.p12")

# Save the server certificate to the JKS format
server.save("server.jks", caalias="cacert")

# Save the client and server certificates to the BKS format. If the BKS
# provider is not installed this will throw.
try:
    client.save("client.bks", caalias="cacert")
    server.save("server.bks", caalias="cacert")
except Exception as ex:
    print("warning: couldn't generate BKS certificates:\n" + str(ex))

factory.destroy()