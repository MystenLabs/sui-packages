module 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math {
    public fun attention_head(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg1: &vector<vector<u64>>, arg2: &vector<vector<u64>>, arg3: u64) : vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed> {
        let v0 = if (0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0) == 64) {
            if (!0x1::vector::is_empty<vector<u64>>(arg1)) {
                0x1::vector::length<vector<u64>>(arg1) == 0x1::vector::length<vector<u64>>(arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906834612430045183);
        let v1 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        assert!(arg3 < 8, 13906834621019979775);
        let v2 = arg3 / 2 * 8;
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 8) {
            0x1::vector::push_back<u64>(&mut v3, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::pack(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, arg3 * 8 + v4)));
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<vector<u64>>(arg1)) {
            let v7 = 0;
            let v8 = 0;
            let v9 = 0;
            while (v9 < 8) {
                let v10 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg1, v6), v2 + v9);
                let v11 = *0x1::vector::borrow<u64>(&v3, v9);
                if (v11 >= 9223372036854775808 != v10 >= 9223372036854775808) {
                    v8 = v8 + ((v11 & 9223372036854775807) as u128) * ((v10 & 9223372036854775807) as u128);
                } else {
                    v7 = v7 + ((v11 & 9223372036854775807) as u128) * ((v10 & 9223372036854775807) as u128);
                };
                v9 = v9 + 1;
            };
            let v12 = if (v7 >= v8) {
                0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(false, (v7 - v8) / 185363)
            } else {
                0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(true, (v8 - v7) / 185363)
            };
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v5, v12);
            v6 = v6 + 1;
        };
        let v13 = probabilities(&v5);
        let v14 = 0;
        while (v14 < 8) {
            let v15 = 0;
            let v16 = 0;
            let v17 = 0;
            while (v17 < 0x1::vector::length<vector<u64>>(arg1)) {
                let v18 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg2, v17), v2 + v14);
                if (v18 >= 9223372036854775808) {
                    v16 = v16 + ((v18 & 9223372036854775807) as u128) * *0x1::vector::borrow<u128>(&v13, v17);
                } else {
                    v15 = v15 + ((v18 & 9223372036854775807) as u128) * *0x1::vector::borrow<u128>(&v13, v17);
                };
                v17 = v17 + 1;
            };
            let v19 = if (v15 >= v16) {
                0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(false, (v15 - v16) / 4294967296)
            } else {
                0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(true, (v16 - v15) / 4294967296)
            };
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v1, v19);
            v14 = v14 + 1;
        };
        v1
    }

    public fun choose(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg1: &vector<u64>, arg2: u64, arg3: bool) : (u64, u64) {
        assert!(0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0) == 512, 13906834775638802431);
        if (!arg3) {
            return (0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::tensor::argmax(arg0, 512), arg2)
        };
        let v0 = *arg0;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 512) {
            0x1::vector::push_back<bool>(&mut v1, false);
            v2 = v2 + 1;
        };
        let v3 = if (0x1::vector::length<u64>(arg1) > 32) {
            0x1::vector::length<u64>(arg1) - 32
        } else {
            0
        };
        let v4 = v3;
        while (v4 < 0x1::vector::length<u64>(arg1)) {
            let v5 = *0x1::vector::borrow<u64>(arg1, v4);
            if (!*0x1::vector::borrow<bool>(&v1, v5)) {
                let v6 = *0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&v0, v5);
                let v7 = if (0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(v6)) {
                    divide(v6, 21, 20)
                } else {
                    divide(v6, 20, 21)
                };
                *0x1::vector::borrow_mut<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v0, v5) = v7;
                *0x1::vector::borrow_mut<bool>(&mut v1, v5) = true;
            };
            v4 = v4 + 1;
        };
        let v8 = vector[];
        let v9 = 0;
        while (v9 < 512) {
            if (0x1::vector::length<u64>(&v8) < 8 || 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::greater(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&v0, v9), *0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&v0, *0x1::vector::borrow<u64>(&v8, 7)))) {
                let v10 = 0;
                while (v10 < 0x1::vector::length<u64>(&v8) && !0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::greater(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&v0, v9), *0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&v0, *0x1::vector::borrow<u64>(&v8, v10)))) {
                    v10 = v10 + 1;
                };
                0x1::vector::insert<u64>(&mut v8, v9, v10);
                if (0x1::vector::length<u64>(&v8) > 8) {
                    0x1::vector::pop_back<u64>(&mut v8);
                };
            };
            v9 = v9 + 1;
        };
        let v11 = &v8;
        let v12 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        let v13 = 0;
        while (v13 < 0x1::vector::length<u64>(v11)) {
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v12, divide(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&v0, *0x1::vector::borrow<u64>(v11, v13)), 5, 4));
            v13 = v13 + 1;
        };
        let v14 = probabilities(&v12);
        let v15 = arg2 ^ arg2 << 13 & 4294967295;
        let v16 = v15 ^ v15 >> 17;
        let v17 = (v16 ^ v16 << 5 & 4294967295) & 4294967295;
        let v18 = 0;
        let v19 = &v14;
        let v20 = 0;
        while (v20 < 0x1::vector::length<u128>(v19)) {
            v18 = v18 + *0x1::vector::borrow<u128>(v19, v20);
            v20 = v20 + 1;
        };
        let v21 = 0;
        let v22 = 0;
        while (v22 < 8) {
            v21 = v21 + *0x1::vector::borrow<u128>(&v14, v22);
            if ((v17 as u128) * v18 / 4294967296 < v21) {
                return (*0x1::vector::borrow<u64>(&v8, v22), v17)
            };
            v22 = v22 + 1;
        };
        (*0x1::vector::borrow<u64>(&v8, 7), v17)
    }

    public fun divide(arg0: 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed, arg1: u128, arg2: u128) : 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed {
        0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::ratio(arg0, arg1, arg2)
    }

    public fun exp_negative(arg0: u128) : u128 {
        if (arg0 >= 32 * 65536) {
            return 0
        };
        let v0 = 4294967296 - arg0 * 4294967296 / 65536 * 4096;
        let v1 = 0;
        while (v1 < 12) {
            let v2 = v0 * v0;
            v0 = v2 / 4294967296;
            v1 = v1 + 1;
        };
        v0
    }

    public fun linear(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64, arg4: u64) : vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed> {
        let v0 = 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0);
        let v1 = if (v0 <= 172) {
            if (0x1::vector::length<u8>(arg1) == v0 * 0x1::vector::length<u8>(arg2)) {
                arg3 + arg4 <= 0x1::vector::length<u8>(arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13906834346142072831);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0)) {
            0x1::vector::push_back<u64>(&mut v2, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::pack(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v3)));
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        let v5 = 0;
        while (v5 < arg4) {
            let v6 = arg3 + v5;
            let v7 = 0;
            let v8 = 0;
            let v9 = 0;
            while (v9 < v0) {
                let v10 = *0x1::vector::borrow<u8>(arg1, v6 * v0 + v9);
                let v11 = v10 >= 128;
                let v12 = if (v11) {
                    256 - (v10 as u64)
                } else {
                    (v10 as u64)
                };
                let v13 = *0x1::vector::borrow<u64>(&v2, v9);
                if (v13 >= 9223372036854775808 != v11) {
                    v8 = v8 + (v13 & 9223372036854775807) * v12;
                } else {
                    v7 = v7 + (v13 & 9223372036854775807) * v12;
                };
                v9 = v9 + 1;
            };
            let v14 = if (v7 >= v8) {
                0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(false, (((v7 - v8) / (1 << *0x1::vector::borrow<u8>(arg2, v6))) as u128))
            } else {
                0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(true, (((v8 - v7) / (1 << *0x1::vector::borrow<u8>(arg2, v6))) as u128))
            };
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v4, v14);
            v5 = v5 + 1;
        };
        v4
    }

    public fun linear8(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg1: &vector<u64>, arg2: &vector<u8>, arg3: u64, arg4: u64) : vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed> {
        let v0 = 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0);
        let v1 = if (v0 > 0) {
            if (v0 <= 172) {
                if (arg3 % 8 == 0) {
                    arg3 + arg4 <= 0x1::vector::length<u8>(arg2)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13906835093466382335);
        assert!(0x1::vector::length<u64>(arg1) == (0x1::vector::length<u8>(arg2) + 7) / 8 * v0, 13906835097761349631);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0)) {
            0x1::vector::push_back<u64>(&mut v2, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::pack(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v3)));
            v3 = v3 + 1;
        };
        let v4 = 0;
        let v5 = 0;
        let v6 = &v2;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(v6)) {
            let v8 = 0x1::vector::borrow<u64>(v6, v7);
            if (*v8 >= 9223372036854775808) {
                v5 = v5 + (*v8 & 9223372036854775807);
            } else {
                v4 = v4 + (*v8 & 9223372036854775807);
            };
            v7 = v7 + 1;
        };
        let v9 = v4 + v5 <= 16843009;
        let v10 = if (v9) {
            8
        } else {
            4
        };
        let v11 = if (v9) {
            32
        } else {
            64
        };
        let v12 = if (v9) {
            4294967295
        } else {
            18446744073709551615
        };
        let v13 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        while (arg3 < arg3 + arg4) {
            let v14 = if (v9) {
                0
            } else {
                arg3 % 8 / 4
            };
            let v15 = 0;
            let v16 = 0;
            let v17 = 0;
            while (v17 < v0) {
                let v18 = if (v9) {
                    (*0x1::vector::borrow<u64>(arg1, arg3 / 8 * v0 + v17) as u256)
                } else {
                    ((*0x1::vector::borrow<u64>(arg1, arg3 / 8 * v0 + v17) >> ((v14 * 32) as u8) & 4294967295) as u256)
                };
                let v19 = if (v9) {
                    let v20 = (v18 | v18 << 96) & 1461501636990620551282746369252908412228459298815;
                    let v21 = (v20 | v20 << 48) & 411369862228566123880278864766078120783549026323861987005628415;
                    (v21 | v21 << 24) & 6874786401724074090536375359574284372422408885825600641753357966377215
                } else {
                    let v22 = (v18 | v18 << 112) & 22300404916163702203072254898040929737834495;
                    (v22 | v22 << 56) & 1600660942523603594864898306482794244293965082972225630372095
                };
                let v23 = *0x1::vector::borrow<u64>(&v2, v17);
                if (v23 >= 9223372036854775808) {
                    v16 = v16 + v19 * ((v23 & 9223372036854775807) as u256);
                } else {
                    v15 = v15 + v19 * ((v23 & 9223372036854775807) as u256);
                };
                v17 = v17 + 1;
            };
            let v24 = 0;
            while (v24 < v10) {
                if (arg3 + v24 < arg3 + arg4) {
                    let v25 = ((v24 * (v11 as u64)) as u8);
                    let v26 = ((v15 >> v25 & v12) as u64) + v5 * 128;
                    let v27 = ((v16 >> v25 & v12) as u64) + v4 * 128;
                    let v28 = if (v26 >= v27) {
                        0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(false, (((v26 - v27) / (1 << *0x1::vector::borrow<u8>(arg2, arg3 + v24))) as u128))
                    } else {
                        0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(true, (((v27 - v26) / (1 << *0x1::vector::borrow<u8>(arg2, arg3 + v24))) as u128))
                    };
                    0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v13, v28);
                };
                v24 = v24 + 1;
            };
            arg3 = arg3 + v10;
        };
        v13
    }

    public fun multiply(arg0: 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed, arg1: 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed) : 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed {
        0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(arg0) != 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(arg1), 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(arg0) * 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(arg1) / 65536)
    }

    public fun pack_rows(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u64> {
        assert!(arg1 > 0 && 0x1::vector::length<u8>(arg0) == arg1 * arg2, 13906834977502265343);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < (arg2 + 7) / 8 * arg1) {
            let v2 = 0;
            let v3 = 0;
            while (v3 < 8) {
                let v4 = v1 / arg1 * 8 + v3;
                let v5 = if (v4 < arg2) {
                    *0x1::vector::borrow<u8>(arg0, v4 * arg1 + v1 % arg1)
                } else {
                    0
                };
                v2 = v2 | ((v5 as u64) + 128) % 256 << ((v3 * 8) as u8);
                v3 = v3 + 1;
            };
            0x1::vector::push_back<u64>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun probabilities(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>) : vector<u128> {
        let v0 = *0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0)) {
            let v2 = 0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v1);
            if (0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::greater(*v2, v0)) {
                v0 = *v2;
            };
            v1 = v1 + 1;
        };
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0)) {
            0x1::vector::push_back<u128>(&mut v3, exp_negative(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::sub(v0, *0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v4)))));
            v4 = v4 + 1;
        };
        let v5 = 0;
        let v6 = &v3;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u128>(v6)) {
            v5 = v5 + *0x1::vector::borrow<u128>(v6, v7);
            v7 = v7 + 1;
        };
        let v8 = &v3;
        let v9 = vector[];
        let v10 = 0;
        while (v10 < 0x1::vector::length<u128>(v8)) {
            0x1::vector::push_back<u128>(&mut v9, *0x1::vector::borrow<u128>(v8, v10) * 4294967296 / v5);
            v10 = v10 + 1;
        };
        v9
    }

    public fun rms(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg1: &vector<u64>) : vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed> {
        assert!(0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0) == 0x1::vector::length<u64>(arg1) && !0x1::vector::is_empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0), 13906834294602465279);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0)) {
            let v2 = 0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v1);
            v0 = v0 + 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(*v2) * 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(*v2);
            v1 = v1 + 1;
        };
        let v3 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0)) {
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v3, multiply(divide(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v4), 65536, 0x1::u128::sqrt(v0 / (0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0) as u128) + 42950)), 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::unpack(*0x1::vector::borrow<u64>(arg1, v4))));
            v4 = v4 + 1;
        };
        v3
    }

    public fun rotate(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg1: &vector<u64>, arg2: u64) : vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed> {
        let v0 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0) / 2) {
            let v2 = v1 * 2;
            let v3 = arg2 * 8 + v2 % 8;
            let v4 = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::unpack(*0x1::vector::borrow<u64>(arg1, v3));
            let v5 = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::unpack(*0x1::vector::borrow<u64>(arg1, v3 + 1));
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v0, divide(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::sub(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v2)) != 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(v4), 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v2)) * 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(v4)), 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v2 + 1)) != 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(v5), 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v2 + 1)) * 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(v5))), 1, 65536));
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v0, divide(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::add(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v2)) != 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(v5), 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v2)) * 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(v5)), 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v2 + 1)) != 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(v4), 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v2 + 1)) * 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(v4))), 1, 65536));
            v1 = v1 + 1;
        };
        v0
    }

    public fun swiglu(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg1: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>) : vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed> {
        assert!(0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0) == 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg1), 13906834449221287935);
        let v0 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0)) {
            let v2 = exp_negative(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v1)));
            let v3 = if (0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::negative(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v1))) {
                v2
            } else {
                4294967296
            };
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v0, multiply(divide(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v1), v3, 4294967296 + v2), *0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

