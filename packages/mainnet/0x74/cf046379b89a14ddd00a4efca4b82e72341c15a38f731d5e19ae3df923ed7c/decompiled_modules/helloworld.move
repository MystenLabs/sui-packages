module 0x74cf046379b89a14ddd00a4efca4b82e72341c15a38f731d5e19ae3df923ed7c::helloworld {
    fun pratica() {
        let v0 = 0x1::string::utf8(b"Hello, world!");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    fun saudacao2() {
        let v0 = 0x1::string::utf8(b"aula de hoje");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

