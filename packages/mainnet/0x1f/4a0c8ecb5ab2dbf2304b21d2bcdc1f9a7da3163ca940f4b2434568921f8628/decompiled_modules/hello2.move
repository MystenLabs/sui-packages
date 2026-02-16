module 0x1f4a0c8ecb5ab2dbf2304b21d2bcdc1f9a7da3163ca940f4b2434568921f8628::hello2 {
    public fun movy_hello2() : u64 {
        42 + 0xbcb4367516cc4f22b7c0265db04e9b4e83b1f24b0b0455020f26e448df6fd08::hello1_upgrade::hello1_upgrade()
    }

    // decompiled from Move bytecode v6
}

