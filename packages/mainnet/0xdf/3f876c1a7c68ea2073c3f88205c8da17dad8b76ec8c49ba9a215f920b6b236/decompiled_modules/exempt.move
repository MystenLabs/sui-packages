module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt {
    public fun is_exempt(arg0: address) : bool {
        arg0 == @0xdd5aab5fa5f378306dd1253be9b665185b0840b6491deb69b945c3f2c0c4770d
    }

    public fun official() : address {
        @0xdd5aab5fa5f378306dd1253be9b665185b0840b6491deb69b945c3f2c0c4770d
    }

    // decompiled from Move bytecode v7
}

