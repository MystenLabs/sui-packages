module 0xb85b49f4e129b9b97d556c9853978b3695d588c8068accd8285d5a9a4078f610::hello3 {
    public fun movy_hello3() : u64 {
        0x8e66aa58f4d9de35eba2e9298093d0766171673711dcb8bed63e2bb9fc7cf9e::hello2::movy_hello2() + 0xb85b49f4e129b9b97d556c9853978b3695d588c8068accd8285d5a9a4078f610::hello4::movy_hello4()
    }

    // decompiled from Move bytecode v6
}

