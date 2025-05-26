module 0x9c11913b6be956a7020cb9e120f03f396e52c3b766164c6163569ac9d7fabe06::ascii {
    public fun is_ascii(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = 0x1::vector::borrow<u8>(v0, v1);
            let v4 = *v3 >= 32 && *v3 <= 127;
            if (!v4) {
                v2 = false;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = true;
        v2
    }

    public fun is_bytes_control(arg0: &vector<u8>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v2 = 0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *v2 <= 31 || *v2 == 127;
            if (!v3) {
                v1 = false;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = true;
        v1
    }

    public fun is_bytes_extended(arg0: &vector<u8>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v2 = 0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *v2 >= 128 && *v2 <= 255;
            if (!v3) {
                v1 = false;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = true;
        v1
    }

    public fun is_bytes_printable(arg0: &vector<u8>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v2 = 0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *v2 >= 32 && *v2 <= 126;
            if (!v3) {
                v1 = false;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = true;
        v1
    }

    // decompiled from Move bytecode v6
}

