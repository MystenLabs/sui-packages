module 0x8e66aa58f4d9de35eba2e9298093d0766171673711dcb8bed63e2bb9fc7cf9e::hello2 {
    public fun movy_hello2() : u64 {
        42 + 0xbcb4367516cc4f22b7c0265db04e9b4e83b1f24b0b0455020f26e448df6fd08::hello1::movy_hello1()
    }

    // decompiled from Move bytecode v6
}

