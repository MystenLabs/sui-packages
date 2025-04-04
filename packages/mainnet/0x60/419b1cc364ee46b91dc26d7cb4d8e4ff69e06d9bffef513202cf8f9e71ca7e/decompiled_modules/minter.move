module 0x60419b1cc364ee46b91dc26d7cb4d8e4ff69e06d9bffef513202cf8f9e71ca7e::minter {
    public entry fun set_minter_cap<T0>(arg0: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::AdminCap, arg1: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::Minter<T0>, arg2: 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::sail_token::MinterCap<T0>) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::set_minter_cap<T0>(arg1, arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

