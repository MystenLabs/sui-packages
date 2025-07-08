module 0x1::type_name {
    struct TypeName has copy, drop, store {
        name: 0x1::ascii::String,
    }

    public fun borrow_string(arg0: &TypeName) : &0x1::ascii::String {
        &arg0.name
    }

    native public fun get<T0>() : TypeName;
    public fun get_address(arg0: &TypeName) : 0x1::ascii::String {
        assert!(!is_primitive(arg0), 0);
        let v0 = 0x1::ascii::as_bytes(&arg0.name);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::address::length() * 2) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(v0, v2));
            v2 = v2 + 1;
        };
        0x1::ascii::string(v1)
    }

    public fun get_module(arg0: &TypeName) : 0x1::ascii::String {
        assert!(!is_primitive(arg0), 0);
        let v0 = 0x1::address::length() * 2 + 2;
        let v1 = 0x1::ascii::as_bytes(&arg0.name);
        let v2 = b"";
        let v3 = 58;
        loop {
            let v4 = 0x1::vector::borrow<u8>(v1, v0);
            if (v4 != &v3) {
                0x1::vector::push_back<u8>(&mut v2, *v4);
                v0 = v0 + 1;
            } else {
                break
            };
        };
        0x1::ascii::string(v2)
    }

    native public fun get_with_original_ids<T0>() : TypeName;
    public fun into_string(arg0: TypeName) : 0x1::ascii::String {
        arg0.name
    }

    public fun is_primitive(arg0: &TypeName) : bool {
        let v0 = 0x1::ascii::as_bytes(&arg0.name);
        let v1 = b"bool";
        if (v0 == &v1) {
            true
        } else {
            let v3 = b"u8";
            if (v0 == &v3) {
                true
            } else {
                let v4 = b"u16";
                if (v0 == &v4) {
                    true
                } else {
                    let v5 = b"u32";
                    if (v0 == &v5) {
                        true
                    } else {
                        let v6 = b"u64";
                        if (v0 == &v6) {
                            true
                        } else {
                            let v7 = b"u128";
                            if (v0 == &v7) {
                                true
                            } else {
                                let v8 = b"u256";
                                if (v0 == &v8) {
                                    true
                                } else {
                                    let v9 = b"address";
                                    if (v0 == &v9) {
                                        true
                                    } else if (0x1::vector::length<u8>(v0) >= 6) {
                                        if (*0x1::vector::borrow<u8>(v0, 0) == 118) {
                                            if (*0x1::vector::borrow<u8>(v0, 1) == 101) {
                                                if (*0x1::vector::borrow<u8>(v0, 2) == 99) {
                                                    if (*0x1::vector::borrow<u8>(v0, 3) == 116) {
                                                        if (*0x1::vector::borrow<u8>(v0, 4) == 111) {
                                                            *0x1::vector::borrow<u8>(v0, 5) == 114
                                                        } else {
                                                            false
                                                        }
                                                    } else {
                                                        false
                                                    }
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // decompiled from Move bytecode v6
}

