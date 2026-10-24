module 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::exempt {
    public fun is_exempt(arg0: address) : bool {
        arg0 == @0xdd5aab5fa5f378306dd1253be9b665185b0840b6491deb69b945c3f2c0c4770d
    }

    public fun official() : address {
        @0xdd5aab5fa5f378306dd1253be9b665185b0840b6491deb69b945c3f2c0c4770d
    }

    // decompiled from Move bytecode v7
}

