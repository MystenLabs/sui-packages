module 0x62e86a2a10f44c585387607d4651e025e77b065d10b6b265e1f049f62d3e567b::practica_sui {
    fun practica() {
        let v0 = 0x1::string::utf8(b"Hello, World!");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

