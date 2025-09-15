module 0x76d9031fd2b56826c68a70b293b3295a45350e2fc6713eb56857c1aa2a88c721::ESTATUS {
    struct Usuario has drop {
        id: 0x1::string::String,
        consumo: u8,
        estatus: bool,
    }

    fun ESTATUS(arg0: Usuario) {
        let v0 = 0x1::string::utf8(b"CONSUMO ACTIVO");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

