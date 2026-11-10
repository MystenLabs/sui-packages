module 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model {
    struct MatrixKey has copy, drop, store {
        pos0: u64,
    }

    struct GainKey has copy, drop, store {
        pos0: u64,
    }

    struct Matrix has drop, store {
        weights: vector<u64>,
        shifts: vector<u8>,
    }

    struct Model has key {
        id: 0x2::object::UID,
        source_hash: vector<u8>,
        sealed: bool,
        rows_loaded: vector<u64>,
        gains_loaded: vector<bool>,
        rope: vector<u64>,
        pieces: vector<vector<u8>>,
        char_ids: vector<u64>,
        merge_keys: vector<u64>,
        merge_ids: vector<u64>,
        ranks: vector<u64>,
    }

    public fun append_matrix(arg0: &mut Model, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(!arg0.sealed, 0);
        let (v0, v1) = dimensions(arg1);
        let v2 = if (!0x1::vector::is_empty<u8>(&arg3)) {
            if (0x1::vector::length<u8>(&arg3) <= 64) {
                0x1::vector::length<u8>(&arg2) <= 8192
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1);
        assert!(0x1::vector::length<u8>(&arg2) == 0x1::vector::length<u8>(&arg3) * v1 && *0x1::vector::borrow<u64>(&arg0.rows_loaded, arg1) + 0x1::vector::length<u8>(&arg3) <= v0, 1);
        assert!(*0x1::vector::borrow<u64>(&arg0.rows_loaded, arg1) % 8 == 0 && (0x1::vector::length<u8>(&arg3) % 8 == 0 || *0x1::vector::borrow<u64>(&arg0.rows_loaded, arg1) + 0x1::vector::length<u8>(&arg3) == v0), 1);
        let v3 = &arg3;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(v3)) {
            assert!(*0x1::vector::borrow<u8>(v3, v4) <= 16, 1);
            v4 = v4 + 1;
        };
        if (*0x1::vector::borrow<u64>(&arg0.rows_loaded, arg1) == 0) {
            let v5 = MatrixKey{pos0: arg1};
            let v6 = Matrix{
                weights : vector[],
                shifts  : b"",
            };
            0x2::dynamic_field::add<MatrixKey, Matrix>(&mut arg0.id, v5, v6);
        };
        *0x1::vector::borrow_mut<u64>(&mut arg0.rows_loaded, arg1) = *0x1::vector::borrow<u64>(&arg0.rows_loaded, arg1) + 0x1::vector::length<u8>(&arg3);
        let v7 = MatrixKey{pos0: arg1};
        let v8 = 0x2::dynamic_field::borrow_mut<MatrixKey, Matrix>(&mut arg0.id, v7);
        0x1::vector::append<u64>(&mut v8.weights, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::pack_rows(&arg2, v1, 0x1::vector::length<u8>(&arg3)));
        0x1::vector::append<u8>(&mut v8.shifts, arg3);
    }

    public fun begin(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        let v0 = new_draft(arg0, arg1);
        0x2::transfer::transfer<Model>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun dimensions(arg0: u64) : (u64, u64) {
        assert!(arg0 < 36, 1);
        if (arg0 == 0) {
            return (512, 64)
        };
        let v0 = (arg0 - 1) % 7;
        let v1 = &v0;
        if (*v1 == 1) {
            (32, 64)
        } else {
            let (v4, v5) = if (*v1 == 2) {
                (64, 32)
            } else {
                let (v6, v7) = if (*v1 == 4) {
                    (172, 64)
                } else if (*v1 == 5) {
                    (64, 172)
                } else if (*v1 == 6) {
                    (172, 64)
                } else {
                    (64, 64)
                };
                (v7, v6)
            };
            (v5, v4)
        }
    }

    public fun embedding(arg0: &Model, arg1: u64) : vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed> {
        assert!(arg1 < 512, 1);
        let v0 = MatrixKey{pos0: 0};
        let v1 = 0x2::dynamic_field::borrow<MatrixKey, Matrix>(&arg0.id, v0);
        let v2 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        let v3 = 0;
        while (v3 < 64) {
            let v4 = ((*0x1::vector::borrow<u64>(&v1.weights, arg1 / 8 * 64 + v3) >> ((arg1 % 8 * 8) as u8) & 255) as u128);
            let v5 = v4 < 128;
            let v6 = if (v5) {
                128 - v4
            } else {
                v4 - 128
            };
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v2, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::raw(v5, v6 * 65536 / (1 << *0x1::vector::borrow<u8>(&v1.shifts, arg1))));
            v3 = v3 + 1;
        };
        v2
    }

    public fun gain(arg0: &Model, arg1: u64) : &vector<u64> {
        let v0 = GainKey{pos0: arg1};
        0x2::dynamic_field::borrow<GainKey, vector<u64>>(&arg0.id, v0)
    }

    public fun install_gain(arg0: &mut Model, arg1: u64, arg2: vector<u64>) {
        let v0 = if (!arg0.sealed) {
            if (arg1 < 11) {
                !*0x1::vector::borrow<bool>(&arg0.gains_loaded, arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        assert!(0x1::vector::length<u64>(&arg2) == 64, 1);
        let v1 = &arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::unpack(*0x1::vector::borrow<u64>(v1, v2));
            v2 = v2 + 1;
        };
        let v3 = GainKey{pos0: arg1};
        0x2::dynamic_field::add<GainKey, vector<u64>>(&mut arg0.id, v3, arg2);
        *0x1::vector::borrow_mut<bool>(&mut arg0.gains_loaded, arg1) = true;
    }

    public fun install_rope(arg0: &mut Model, arg1: vector<u64>) {
        assert!(!arg0.sealed && 0x1::vector::is_empty<u64>(&arg0.rope), 0);
        assert!(0x1::vector::length<u64>(&arg1) == 1024, 1);
        let v0 = &arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(v0)) {
            assert!(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::magnitude(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::unpack(*0x1::vector::borrow<u64>(v0, v1))) <= 65536, 1);
            v1 = v1 + 1;
        };
        arg0.rope = arg1;
    }

    public fun install_tokenizer(arg0: &mut Model, arg1: vector<vector<u8>>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>) {
        assert!(!arg0.sealed && 0x1::vector::is_empty<vector<u8>>(&arg0.pieces), 0);
        let v0 = if (0x1::vector::length<vector<u8>>(&arg1) == 512) {
            if (0x1::vector::length<u64>(&arg2) == 256) {
                0x1::vector::length<u64>(&arg5) == 512
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4) && 0x1::vector::length<u64>(&arg3) <= 1024, 1);
        let v1 = &arg1;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(v1, v2)) <= 32, 1);
            v2 = v2 + 1;
        };
        let v3 = &arg2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(v3)) {
            assert!(*0x1::vector::borrow<u64>(v3, v4) < 512, 1);
            v4 = v4 + 1;
        };
        let v5 = &arg4;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(v5)) {
            assert!(*0x1::vector::borrow<u64>(v5, v6) < 512, 1);
            v6 = v6 + 1;
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&arg3)) {
            assert!(*0x1::vector::borrow<u64>(&arg3, v7) < 262144, 1);
            if (v7 > 0) {
                assert!(*0x1::vector::borrow<u64>(&arg3, v7) > *0x1::vector::borrow<u64>(&arg3, v7 - 1), 1);
            };
            v7 = v7 + 1;
        };
        arg0.pieces = arg1;
        arg0.char_ids = arg2;
        arg0.merge_keys = arg3;
        arg0.merge_ids = arg4;
        arg0.ranks = arg5;
    }

    public fun is_sealed(arg0: &Model) : bool {
        arg0.sealed
    }

    fun new_draft(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Model {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 36) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 11) {
            0x1::vector::push_back<bool>(&mut v2, false);
            v3 = v3 + 1;
        };
        Model{
            id           : 0x2::object::new(arg1),
            source_hash  : arg0,
            sealed       : false,
            rows_loaded  : v0,
            gains_loaded : v2,
            rope         : vector[],
            pieces       : vector[],
            char_ids     : vector[],
            merge_keys   : vector[],
            merge_ids    : vector[],
            ranks        : vector[],
        }
    }

    public fun piece(arg0: &Model, arg1: u64) : vector<u8> {
        *0x1::vector::borrow<vector<u8>>(&arg0.pieces, arg1)
    }

    public fun project(arg0: &Model, arg1: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg2: u64, arg3: u64, arg4: u64) : vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed> {
        let v0 = MatrixKey{pos0: arg2};
        let v1 = 0x2::dynamic_field::borrow<MatrixKey, Matrix>(&arg0.id, v0);
        0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::linear8(arg1, &v1.weights, &v1.shifts, arg3, arg4)
    }

    public fun rope(arg0: &Model) : &vector<u64> {
        &arg0.rope
    }

    public fun seal(arg0: Model) : 0x2::object::ID {
        assert!(!arg0.sealed, 0);
        let v0 = 0;
        while (v0 < 36) {
            let (v1, _) = dimensions(v0);
            assert!(*0x1::vector::borrow<u64>(&arg0.rows_loaded, v0) == v1, 1);
            v0 = v0 + 1;
        };
        let v3 = &arg0.gains_loaded;
        let v4 = 0;
        while (v4 < 0x1::vector::length<bool>(v3)) {
            assert!(*0x1::vector::borrow<bool>(v3, v4), 1);
            v4 = v4 + 1;
        };
        assert!(0x1::vector::length<vector<u8>>(&arg0.pieces) == 512 && 0x1::vector::length<u64>(&arg0.rope) == 1024, 1);
        arg0.sealed = true;
        0x2::transfer::freeze_object<Model>(arg0);
        0x2::object::id<Model>(&arg0)
    }

    public fun source_hash(arg0: &Model) : vector<u8> {
        arg0.source_hash
    }

    public fun tokenize(arg0: &Model, arg1: &0x1::string::String) : vector<u64> {
        let v0 = if (arg0.sealed) {
            if (0x1::string::length(arg1) > 0) {
                0x1::string::length(arg1) <= 160
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 1);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&arg0.char_ids, 32));
        let v3 = 0x1::string::as_bytes(arg1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(v3)) {
            if (*0x1::vector::borrow<u8>(v3, v4) < 128) {
                0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&arg0.char_ids, (*0x1::vector::borrow<u8>(v3, v4) as u64)));
                v4 = v4 + 1;
                continue
            };
            let v5 = v4 + 1;
            while (v5 < 0x1::vector::length<u8>(v3) && *0x1::vector::borrow<u8>(v3, v5) & 192 == 128) {
                v5 = v5 + 1;
            };
            let v6 = b"";
            let v7 = 0;
            while (v7 < v5 - v4) {
                0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(v3, v4 + v7));
                v7 = v7 + 1;
            };
            let v8 = 512;
            let v9 = 259;
            while (v9 < 512 && v8 == 512) {
                v9 = v9 + 1;
            };
            if (v8 < 512) {
                0x1::vector::push_back<u64>(&mut v1, v8);
            } else {
                let v10 = 0;
                while (v10 < v5 - v4) {
                    0x1::vector::push_back<u64>(&mut v1, (*0x1::vector::borrow<u8>(v3, v4 + v10) as u64) + 3);
                    v10 = v10 + 1;
                };
            };
            v4 = v5;
        };
        loop {
            let v11 = 0x1::vector::length<u64>(&v1);
            let v12 = 0;
            let v13 = 0;
            let v14 = 0;
            while (v14 < 0x1::vector::length<u64>(&v1) - 1) {
                let v15 = *0x1::vector::borrow<u64>(&v1, v14) * 512 + *0x1::vector::borrow<u64>(&v1, v14 + 1);
                let v16 = 0;
                let v17 = 0x1::vector::length<u64>(&arg0.merge_keys);
                while (v16 < v17) {
                    v17 = v16 + (v17 - v16) / 2;
                    if (*0x1::vector::borrow<u64>(&arg0.merge_keys, v17) < v15) {
                        v16 = v17 + 1;
                        continue
                    };
                };
                if (v16 < 0x1::vector::length<u64>(&arg0.merge_keys) && *0x1::vector::borrow<u64>(&arg0.merge_keys, v16) == v15) {
                    let v18 = *0x1::vector::borrow<u64>(&arg0.merge_ids, v16);
                    if (v11 == 0x1::vector::length<u64>(&v1) || *0x1::vector::borrow<u64>(&arg0.ranks, v18) > v13) {
                        v11 = v14;
                        v12 = v18;
                        v13 = *0x1::vector::borrow<u64>(&arg0.ranks, v18);
                    };
                };
                v14 = v14 + 1;
            };
            if (v11 == 0x1::vector::length<u64>(&v1)) {
                break
            };
            *0x1::vector::borrow_mut<u64>(&mut v1, v11) = v12;
            0x1::vector::remove<u64>(&mut v1, v11 + 1);
        };
        v1
    }

    // decompiled from Move bytecode v7
}

