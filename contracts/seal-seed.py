from Crypto.Hash import keccak
import binascii

owner = binascii.unhexlify("Fbc3ED924FfbcbF0e0189E66DE7b7e89c2b4a992")
seed = b"I hope you had fun in COMP5568!".ljust(32, b'\x00')

k = keccak.new(digest_bits=256)
k.update(owner)
k.update(seed)

print("OWNER:\t%s" % binascii.hexlify(owner))
print("SEED:\t%s" % seed)
print("SEED:\t%s" % binascii.hexlify(seed))
print("SEALED SEED: %s" % k.hexdigest())
