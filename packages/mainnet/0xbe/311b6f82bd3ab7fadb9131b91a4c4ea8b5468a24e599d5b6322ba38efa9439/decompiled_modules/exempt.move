module 0x6a5e43b04523f8acf9cd5a07c0868eb37d549a947d78a4f9628f2ec34b5e54fd::exempt {
    public fun is_exempt(arg0: address) : bool {
        arg0 == @0xdd5aab5fa5f378306dd1253be9b665185b0840b6491deb69b945c3f2c0c4770d
    }

    public fun official() : address {
        @0xdd5aab5fa5f378306dd1253be9b665185b0840b6491deb69b945c3f2c0c4770d
    }

    // decompiled from Move bytecode v7
}

