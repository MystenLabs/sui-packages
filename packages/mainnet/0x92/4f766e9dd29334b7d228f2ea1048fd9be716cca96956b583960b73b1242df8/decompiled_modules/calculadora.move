module 0x924f766e9dd29334b7d228f2ea1048fd9be716cca96956b583960b73b1242df8::calculadora {
    fun divide(arg0: &u64, arg1: &u64) : u64 {
        if (*arg0 >= *arg1) {
            *arg0 / *arg1
        } else {
            0
        }
    }

    public fun exe_calculadora() {
        let v0 = 144;
        let v1 = 2;
        let v2 = 0x1::string::utf8(b"Calculadora Basica");
        0x1::debug::print<0x1::string::String>(&v2);
        let v3 = 0x1::string::utf8(b"Numero 1");
        0x1::debug::print<0x1::string::String>(&v3);
        0x1::debug::print<u64>(&v0);
        let v4 = 0x1::string::utf8(b"Numero 2");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<u64>(&v1);
        let v5 = soma(&v0, &v1);
        let v6 = 0x1::string::utf8(b"A soma total:");
        0x1::debug::print<0x1::string::String>(&v6);
        0x1::debug::print<u64>(&v5);
        let v7 = subt(&v0, &v1);
        let v8 = 0x1::string::utf8(b"A substracao total:");
        0x1::debug::print<0x1::string::String>(&v8);
        0x1::debug::print<u64>(&v7);
        let v9 = multiplica(&v0, &v1);
        let v10 = 0x1::string::utf8(b"A multiplicacao :");
        0x1::debug::print<0x1::string::String>(&v10);
        0x1::debug::print<u64>(&v9);
        let v11 = divide(&v0, &v1);
        let v12 = 0x1::string::utf8(b"A divicao:");
        0x1::debug::print<0x1::string::String>(&v12);
        0x1::debug::print<u64>(&v11);
    }

    fun multiplica(arg0: &u64, arg1: &u64) : u64 {
        if (*arg0 >= *arg1) {
            *arg0 * *arg1
        } else {
            0
        }
    }

    fun soma(arg0: &u64, arg1: &u64) : u64 {
        *arg0 + *arg1
    }

    fun subt(arg0: &u64, arg1: &u64) : u64 {
        if (*arg0 >= *arg1) {
            *arg0 - *arg1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

