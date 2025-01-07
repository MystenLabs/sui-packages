module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util {
    public fun is_lowercase(arg0: u8) : bool {
        arg0 >= 97 && arg0 <= 122
    }

    public fun is_uppercase(arg0: u8) : bool {
        arg0 >= 65 && arg0 <= 90
    }

    public fun to_lowercase(arg0: &mut vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<u8>(arg0, v0);
            if (is_uppercase(*v1)) {
                *v1 = *v1 + 32;
            };
            v0 = v0 + 1;
        };
    }

    public fun to_uppercase(arg0: &mut vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<u8>(arg0, v0);
            if (is_lowercase(*v1)) {
                *v1 = *v1 - 32;
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

