module 0xf6c0f3d4e2323107050ac10daad34ab25f706461396ef4553831d9703f147984::helloword {
    fun pratica() {
        let v0 = 0x1::string::utf8(b"UM NOVO MUNDO CHAMADO MOVE!");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

