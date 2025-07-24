module 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::multiaddr {
    fun is_valid_dns(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::length(arg0);
        if (v0 < 1 || v0 > 253) {
            return false
        };
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            if (0x1::string::substring(arg0, v3, v3 + 1) == 0x1::string::utf8(b".")) {
                let v4 = 0x1::string::substring(arg0, v2, v3);
                if (0x1::string::length(&v4) == 0) {
                    return false
                };
                0x1::vector::push_back<0x1::string::String>(&mut v1, v4);
                v2 = v3 + 1;
            };
            v3 = v3 + 1;
        };
        let v5 = 0x1::string::substring(arg0, v2, v0);
        if (0x1::string::length(&v5) == 0) {
            return false
        };
        0x1::vector::push_back<0x1::string::String>(&mut v1, v5);
        let v6 = 0x1::vector::length<0x1::string::String>(&v1);
        if (v6 < 1) {
            return false
        };
        let v7 = 0;
        while (v7 < v6) {
            let v8 = 0x1::vector::borrow<0x1::string::String>(&v1, v7);
            let v9 = 0x1::string::length(v8);
            if (v9 < 1 || v9 > 63) {
                return false
            };
            let v10 = 0x1::string::as_bytes(v8);
            let v11 = 0;
            while (v11 < v9) {
                let v12 = *0x1::vector::borrow<u8>(v10, v11);
                let v13 = v12 >= 65 && v12 <= 90 || v12 >= 97 && v12 <= 122;
                let v14 = v12 >= 48 && v12 <= 57;
                let v15 = v12 == 45;
                let v16 = if (!v13) {
                    if (!v14) {
                        !v15
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v16) {
                    return false
                };
                if (v15) {
                    if (v11 == 0 || v11 == v9 - 1) {
                        return false
                    };
                };
                v11 = v11 + 1;
            };
            v7 = v7 + 1;
        };
        true
    }

    fun is_valid_ipv4(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::length(arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            if (0x1::string::substring(arg0, v3, v3 + 1) == 0x1::string::utf8(b".")) {
                0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::substring(arg0, v2, v3));
                v2 = v3 + 1;
            };
            v3 = v3 + 1;
        };
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::substring(arg0, v2, v0));
        if (0x1::vector::length<0x1::string::String>(&v1) != 4) {
            return false
        };
        let v4 = 0;
        while (v4 < 4) {
            let v5 = 0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(&v1, v4));
            let v6 = 0x1::vector::length<u8>(v5);
            if (v6 == 0 || v6 > 3) {
                return false
            };
            let v7 = 0;
            while (v7 < v6) {
                let v8 = *0x1::vector::borrow<u8>(v5, v7);
                if (v8 < 48 || v8 > 57) {
                    return false
                };
                v7 = v7 + 1;
            };
            if (v6 == 3) {
                let v9 = *0x1::vector::borrow<u8>(v5, 0);
                let v10 = *0x1::vector::borrow<u8>(v5, 1);
                if (v9 > 50) {
                    return false
                };
                if (v9 == 50) {
                    if (v10 > 53) {
                        return false
                    };
                    if (v10 == 53 && *0x1::vector::borrow<u8>(v5, 2) > 53) {
                        return false
                    };
                };
            } else if (v6 == 2) {
                let v11 = *0x1::vector::borrow<u8>(v5, 0);
                if (v11 > 50) {
                    return false
                };
                if (v11 == 50 && *0x1::vector::borrow<u8>(v5, 1) > 53) {
                    return false
                };
            };
            v4 = v4 + 1;
        };
        true
    }

    fun is_valid_ipv6(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::length(arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        let v3 = 0;
        let v4 = false;
        let v5 = false;
        while (v3 < v0) {
            if (0x1::string::substring(arg0, v3, v3 + 1) == 0x1::string::utf8(b":")) {
                if (v3 > 0 && 0x1::string::substring(arg0, v3 - 1, v3) == 0x1::string::utf8(b":")) {
                    if (v5) {
                        return false
                    };
                    v5 = true;
                    v4 = true;
                } else {
                    if (!v4) {
                        let v6 = 0x1::string::substring(arg0, v2, v3);
                        if (0x1::string::length(&v6) > 0) {
                            0x1::vector::push_back<0x1::string::String>(&mut v1, v6);
                        };
                    };
                    v4 = false;
                };
                v2 = v3 + 1;
            };
            v3 = v3 + 1;
        };
        let v7 = 0x1::string::substring(arg0, v2, v0);
        if (0x1::string::length(&v7) > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, v7);
        };
        let v8 = 0x1::vector::length<0x1::string::String>(&v1);
        if (!v5 && v8 != 8) {
            return false
        };
        if (v5 && v8 >= 8) {
            return false
        };
        let v9 = 0;
        while (v9 < v8) {
            let v10 = 0x1::vector::borrow<0x1::string::String>(&v1, v9);
            let v11 = 0x1::string::length(v10);
            if (v11 == 0 || v11 > 4) {
                return false
            };
            let v12 = 0x1::string::as_bytes(v10);
            let v13 = 0;
            while (v13 < v11) {
                let v14 = *0x1::vector::borrow<u8>(v12, v13);
                let v15 = v14 >= 48 && v14 <= 57;
                let v16 = v14 >= 97 && v14 <= 102;
                let v17 = v14 >= 65 && v14 <= 70;
                let v18 = if (!v15) {
                    if (!v16) {
                        !v17
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v18) {
                    return false
                };
                v13 = v13 + 1;
            };
            v9 = v9 + 1;
        };
        true
    }

    public fun validate_tcp(arg0: &0x1::string::String) : bool {
        validate_with_transport(arg0, 0x1::string::utf8(b"tcp"))
    }

    public fun validate_udp(arg0: &0x1::string::String) : bool {
        validate_with_transport(arg0, 0x1::string::utf8(b"udp"))
    }

    fun validate_with_transport(arg0: &0x1::string::String, arg1: 0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 < 1) {
            return false
        };
        if (*0x1::vector::borrow<u8>(v0, 0) != 47) {
            return false
        };
        let v2 = 1;
        let v3 = 0;
        let v4 = 0x1::string::utf8(b"");
        let v5 = 0x1::string::utf8(b"");
        let v6 = 0x1::string::utf8(b"");
        let v7 = 0x1::string::utf8(b"");
        let v8 = 1;
        while (v8 < v1) {
            if (*0x1::vector::borrow<u8>(v0, v8) == 47 || v8 == v1 - 1) {
                let v9 = if (v8 == v1 - 1) {
                    v8 + 1
                } else {
                    v8
                };
                let v10 = 0x1::string::substring(arg0, v2, v9);
                if (v3 == 0) {
                    v4 = v10;
                } else if (v3 == 1) {
                    v5 = v10;
                } else if (v3 == 2) {
                    v6 = v10;
                } else if (v3 == 3) {
                    v7 = v10;
                } else {
                    let v11 = if (v10 == 0x1::string::utf8(b"http")) {
                        true
                    } else if (v10 == 0x1::string::utf8(b"https")) {
                        true
                    } else {
                        v10 == 0x1::string::utf8(b"quic")
                    };
                    if (!v11) {
                        if (v3 == 4) {
                            return false
                        };
                        break
                    };
                };
                v2 = v8 + 1;
                v3 = v3 + 1;
            };
            v8 = v8 + 1;
        };
        if (v3 < 4) {
            return false
        };
        let v12 = 0x1::string::utf8(b"ip4");
        let v13 = 0x1::string::utf8(b"ip6");
        let v14 = 0x1::string::utf8(b"dns4");
        let v15 = 0x1::string::utf8(b"dns6");
        let v16 = 0x1::string::utf8(b"dns");
        let v17 = if (v4 != v12) {
            if (v4 != v13) {
                if (v4 != v14) {
                    if (v4 != v15) {
                        v4 != v16
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
        };
        if (v17) {
            return false
        };
        if (v4 == v12) {
            if (!is_valid_ipv4(&v5)) {
                return false
            };
        } else if (v4 == v13) {
            if (!is_valid_ipv6(&v5)) {
                return false
            };
        } else {
            let v18 = if (v4 == v14) {
                true
            } else if (v4 == v15) {
                true
            } else {
                v4 == v16
            };
            if (v18) {
                if (!is_valid_dns(&v5)) {
                    return false
                };
            };
        };
        if (v6 != arg1) {
            return false
        };
        if (0x1::string::length(&v7) == 0) {
            return false
        };
        let v19 = 0x1::string::as_bytes(&v7);
        let v20 = 0;
        let v21 = true;
        while (v20 < 0x1::vector::length<u8>(v19)) {
            let v22 = *0x1::vector::borrow<u8>(v19, v20);
            if (v22 < 48 || v22 > 57) {
                v21 = false;
                break
            };
            v20 = v20 + 1;
        };
        v21
    }

    // decompiled from Move bytecode v6
}

