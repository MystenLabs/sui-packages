module 0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::deserialize {
    public fun deserialize(arg0: &0x1::string::String) : (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONValue, 0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONObjectStore) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::new_object_store();
        let v2 = &mut v1;
        let (v3, v4) = parse_value(v2, v0, 0);
        assert!(v4 == 0x1::vector::length<u8>(v0), 0);
        (v3, v1)
    }

    public fun char_is_digit(arg0: u8) : bool {
        arg0 >= 48 && arg0 <= 57
    }

    public fun char_to_digit(arg0: u8) : u8 {
        arg0 - 48
    }

    public fun parse_array(arg0: &mut 0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONObjectStore, arg1: &vector<u8>, arg2: u64) : (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONValue, u64) {
        let v0 = 0x1::vector::empty<0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONValue>();
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = false;
        assert!(*0x1::vector::borrow<u8>(arg1, arg2) == 91, 0);
        let v3 = arg2 + 1;
        let v4;
        loop {
            assert!(v3 < v1, 0);
            if (*0x1::vector::borrow<u8>(arg1, v3) == 93 && !v2) {
                v3 = v3 + 1;
                /* label 13 */
                return (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::array(arg0, v0), v3)
            };
            let (v5, v4) = parse_value(arg0, arg1, v3);
            0x1::vector::push_back<0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONValue>(&mut v0, v5);
            assert!(v4 < v1, 0);
            if (*0x1::vector::borrow<u8>(arg1, v4) == 44) {
                v2 = true;
                v3 = v4 + 1;
            } else {
                break
            };
        };
        assert!(*0x1::vector::borrow<u8>(arg1, v4) == 93, 0);
        v3 = v4 + 1;
        /* goto 13 */
    }

    fun parse_false(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(arg1 + 4 < 0x1::vector::length<u8>(arg0), 0);
        let v0 = if (*0x1::vector::borrow<u8>(arg0, arg1 + 1) == 97) {
            if (*0x1::vector::borrow<u8>(arg0, arg1 + 2) == 108) {
                if (*0x1::vector::borrow<u8>(arg0, arg1 + 3) == 115) {
                    *0x1::vector::borrow<u8>(arg0, arg1 + 4) == 101
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        arg1 + 5
    }

    fun parse_null(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(arg1 + 3 < 0x1::vector::length<u8>(arg0), 0);
        let v0 = if (*0x1::vector::borrow<u8>(arg0, arg1 + 1) == 117) {
            if (*0x1::vector::borrow<u8>(arg0, arg1 + 2) == 108) {
                *0x1::vector::borrow<u8>(arg0, arg1 + 3) == 108
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        arg1 + 4
    }

    fun parse_num(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = arg1;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (char_is_digit(*0x1::vector::borrow<u8>(arg0, v0))) {
                v0 = v0 + 1;
            } else {
                break
            };
        };
        let v1 = 0;
        let v2 = v0 - 1;
        while (v2 >= arg1) {
            v1 = v1 + (char_to_digit(*0x1::vector::borrow<u8>(arg0, v2)) as u64) * 0x1::u64::pow(10, ((v0 - v2 - 1) as u8));
            v2 = v2 - 1;
        };
        (v1, v0)
    }

    public fun parse_object(arg0: &mut 0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONObjectStore, arg1: &vector<u8>, arg2: u64) : (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONValue, u64) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONValue>();
        let v1 = false;
        let v2 = 0x1::vector::length<u8>(arg1);
        let v3 = arg2 + 1;
        loop {
            assert!(v3 < v2, 0);
            if (*0x1::vector::borrow<u8>(arg1, v3) == 34) {
                let (v4, v5) = parse_string(arg1, v3);
                assert!(v5 < v2, 0);
                assert!(*0x1::vector::borrow<u8>(arg1, v5) == 58, 0);
                let (v6, v7) = parse_value(arg0, arg1, v5 + 1);
                0x2::vec_map::insert<0x1::string::String, 0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONValue>(&mut v0, v4, v6);
                assert!(v7 < v2, 0);
                if (*0x1::vector::borrow<u8>(arg1, v7) == 44) {
                    v1 = true;
                    v3 = v7 + 1;
                    continue
                };
                assert!(*0x1::vector::borrow<u8>(arg1, v7) == 125, 0);
                v3 = v7 + 1;
                /* label 19 */
                return (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::object(arg0, v0), v3)
            } else {
                break
            };
        };
        assert!(*0x1::vector::borrow<u8>(arg1, v3) == 125, 0);
        assert!(!v1, 0);
        v3 = v3 + 1;
        /* goto 19 */
    }

    public fun parse_string(arg0: &vector<u8>, arg1: u64) : (0x1::string::String, u64) {
        let v0 = arg1 + 1;
        let v1 = false;
        let v2 = 0x1::vector::empty<u8>();
        loop {
            assert!(v0 < 0x1::vector::length<u8>(arg0), 0);
            let v3 = *0x1::vector::borrow<u8>(arg0, v0);
            if (v1) {
                v1 = false;
                0x1::vector::push_back<u8>(&mut v2, v3);
            } else if (v3 == 92) {
                v1 = true;
            } else {
                if (v3 == 34) {
                    break
                };
                0x1::vector::push_back<u8>(&mut v2, v3);
            };
            v0 = v0 + 1;
        };
        (0x1::string::utf8(v2), v0 + 1)
    }

    fun parse_true(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(arg1 + 3 < 0x1::vector::length<u8>(arg0), 0);
        let v0 = if (*0x1::vector::borrow<u8>(arg0, arg1 + 1) == 114) {
            if (*0x1::vector::borrow<u8>(arg0, arg1 + 2) == 117) {
                *0x1::vector::borrow<u8>(arg0, arg1 + 3) == 101
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        arg1 + 4
    }

    fun parse_value(arg0: &mut 0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONObjectStore, arg1: &vector<u8>, arg2: u64) : (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::JSONValue, u64) {
        assert!(arg2 < 0x1::vector::length<u8>(arg1), 0);
        let v0 = *0x1::vector::borrow<u8>(arg1, arg2);
        if (v0 == 110) {
            return (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::null(), parse_null(arg1, arg2))
        };
        if (v0 == 116) {
            return (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::boolean(true), parse_true(arg1, arg2))
        };
        if (v0 == 102) {
            return (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::boolean(false), parse_false(arg1, arg2))
        };
        if (char_is_digit(v0)) {
            let (v1, v2) = parse_num(arg1, arg2);
            return (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::number(v1), v2)
        };
        if (v0 == 34) {
            let (v3, v4) = parse_string(arg1, arg2);
            return (0xc314259697320ddc2118f2bedb43d1d6cc922abaaf6e3427f7103b106ccd120f::json::string(v3), v4)
        };
        if (v0 == 91) {
            return parse_array(arg0, arg1, arg2)
        };
        assert!(v0 == 123, 0);
        parse_object(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

