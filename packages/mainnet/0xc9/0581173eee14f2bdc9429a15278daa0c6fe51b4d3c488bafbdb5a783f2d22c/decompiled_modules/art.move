module 0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art {
    struct Library has key {
        id: 0x2::object::UID,
        layers: 0x2::table::Table<u16, Layer>,
        sealed: bool,
    }

    struct LibraryCap has store, key {
        id: 0x2::object::UID,
        library: 0x2::object::ID,
    }

    struct Layer has store {
        slot: u8,
        name: 0x1::string::String,
        palette: vector<u32>,
        runs: vector<u8>,
    }

    public fun add_layer(arg0: &mut Library, arg1: &LibraryCap, arg2: u16, arg3: u8, arg4: 0x1::string::String, arg5: vector<u32>, arg6: vector<u8>) {
        assert!(arg1.library == 0x2::object::id<Library>(arg0), 13863768872273969155);
        assert!(!arg0.sealed, 13863205926615384065);
        assert!(arg3 < 7, 13864050355840745477);
        assert!(!0x2::table::contains<u16, Layer>(&arg0.layers, arg2), 13864894785066237963);
        let v0 = 0x1::vector::length<u32>(&arg5);
        if (v0 > 0) {
            if (v0 <= 255) {
                let v1 = &arg5;
                let v2 = 0;
                let v3;
                while (v2 < 0x1::vector::length<u32>(v1)) {
                    if (!(*0x1::vector::borrow<u32>(v1, v2) < 16777216)) {
                        v3 = false;
                        /* label 20 */
                        /* label 21 */
                        assert!(v3, 13864331843702489095);
                        assert!(0x1::vector::length<u8>(&arg6) % 2 == 0, 13864613322974298121);
                        let v4 = 0;
                        let v5 = 0;
                        while (v5 < 0x1::vector::length<u8>(&arg6)) {
                            assert!(*0x1::vector::borrow<u8>(&arg6, v5) > 0 && (*0x1::vector::borrow<u8>(&arg6, v5 + 1) as u64) <= v0, 13864613340154167305);
                            v4 = v4 + (*0x1::vector::borrow<u8>(&arg6, v5) as u64);
                            v5 = v5 + 2;
                        };
                        assert!(v4 == 5184, 13864613357334036489);
                        let v6 = Layer{
                            slot    : arg3,
                            name    : arg4,
                            palette : arg5,
                            runs    : arg6,
                        };
                        0x2::table::add<u16, Layer>(&mut arg0.layers, arg2, v6);
                        return
                    };
                    v2 = v2 + 1;
                };
                v3 = true;
                /* goto 20 */
            } else {
                /* goto 21 */
            };
        } else {
            /* goto 21 */
        };
    }

    public fun base64_into(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = 0;
        while (v2 + 2 < v1) {
            let v3 = (*0x1::vector::borrow<u8>(arg1, v2) as u64) << 16 | (*0x1::vector::borrow<u8>(arg1, v2 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg1, v2 + 2) as u64);
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v3 >> 18));
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v3 >> 12 & 63));
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v3 >> 6 & 63));
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v3 & 63));
            v2 = v2 + 3;
        };
        if (v1 - v2 == 1) {
            let v4 = (*0x1::vector::borrow<u8>(arg1, v2) as u64) << 16;
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v4 >> 18));
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v4 >> 12 & 63));
            0x1::vector::push_back<u8>(arg0, 61);
            0x1::vector::push_back<u8>(arg0, 61);
        } else if (v1 - v2 == 2) {
            let v5 = (*0x1::vector::borrow<u8>(arg1, v2) as u64) << 16 | (*0x1::vector::borrow<u8>(arg1, v2 + 1) as u64) << 8;
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v5 >> 18));
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v5 >> 12 & 63));
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v5 >> 6 & 63));
            0x1::vector::push_back<u8>(arg0, 61);
        };
    }

    public fun bmp_header(arg0: &vector<u32>) : vector<u8> {
        let v0 = 0x1::vector::length<u32>(arg0);
        while (v0 % 3 != 0) {
            v0 = v0 + 1;
        };
        let v1 = 54 + 4 * v0;
        let v2 = b"BM";
        let v3 = &mut v2;
        push_le32(v3, ((v1 + 5184) as u32));
        let v4 = &mut v2;
        push_le32(v4, 0);
        let v5 = &mut v2;
        push_le32(v5, (v1 as u32));
        let v6 = &mut v2;
        push_le32(v6, 40);
        let v7 = &mut v2;
        push_le32(v7, (72 as u32));
        let v8 = &mut v2;
        push_le32(v8, (72 as u32));
        0x1::vector::push_back<u8>(&mut v2, 1);
        0x1::vector::push_back<u8>(&mut v2, 0);
        0x1::vector::push_back<u8>(&mut v2, 8);
        0x1::vector::push_back<u8>(&mut v2, 0);
        let v9 = &mut v2;
        push_le32(v9, 0);
        let v10 = &mut v2;
        push_le32(v10, (5184 as u32));
        let v11 = &mut v2;
        push_le32(v11, 2835);
        let v12 = &mut v2;
        push_le32(v12, 2835);
        let v13 = &mut v2;
        push_le32(v13, (v0 as u32));
        let v14 = &mut v2;
        push_le32(v14, 0);
        let v15 = 0;
        while (v15 < v0) {
            let v16 = if (v15 < 0x1::vector::length<u32>(arg0)) {
                *0x1::vector::borrow<u32>(arg0, v15)
            } else {
                0
            };
            0x1::vector::push_back<u8>(&mut v2, ((v16 & 255) as u8));
            0x1::vector::push_back<u8>(&mut v2, ((v16 >> 8 & 255) as u8));
            0x1::vector::push_back<u8>(&mut v2, ((v16 >> 16 & 255) as u8));
            0x1::vector::push_back<u8>(&mut v2, 0);
            v15 = v15 + 1;
        };
        v2
    }

    public fun compose(arg0: &Library, arg1: &vector<u16>) : (0x1::string::String, vector<0x1::string::String>, vector<0x1::string::String>) {
        assert!(0x1::vector::length<u16>(arg1) > 0, 13865176397482033165);
        let v0 = vector[];
        let v1 = b"";
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u16>(arg1)) {
            assert!(0x2::table::contains<u16, Layer>(&arg0.layers, *0x1::vector::borrow<u16>(arg1, v6)), 13865739394680356881);
            let v7 = 0x2::table::borrow<u16, Layer>(&arg0.layers, *0x1::vector::borrow<u16>(arg1, v6));
            assert!(v6 == 0 && v7.slot == 0 || v7.slot > v4, 13865176453316608013);
            v4 = v7.slot;
            let v8 = &v7.palette;
            let v9 = 0;
            while (v9 < 0x1::vector::length<u32>(v8)) {
                0x1::vector::push_back<u32>(&mut v0, *0x1::vector::borrow<u32>(v8, v9));
                v9 = v9 + 1;
            };
            assert!(0x1::vector::length<u32>(&v0) <= 255, 13865457945473318927);
            let v10 = &v7.runs;
            let v11 = 0;
            let v12 = 0;
            if (v6 == 0) {
                while (v11 < 0x1::vector::length<u8>(v10)) {
                    let v13 = *0x1::vector::borrow<u8>(v10, v11 + 1);
                    let v14 = if (v13 != 0) {
                        v13 - 1 + (0x1::vector::length<u32>(&v0) as u8)
                    } else {
                        if (v5 == 0) {
                            0x1::vector::push_back<u32>(&mut v0, 0);
                            v5 = (0x1::vector::length<u32>(&v0) as u8);
                        };
                        v5 - 1
                    };
                    let v15 = *0x1::vector::borrow<u8>(v10, v11);
                    while (v15 > 0) {
                        0x1::vector::push_back<u8>(&mut v1, v14);
                        v15 = v15 - 1;
                    };
                    v11 = v11 + 2;
                };
            } else {
                while (v11 < 0x1::vector::length<u8>(v10)) {
                    let v16 = v12 + (*0x1::vector::borrow<u8>(v10, v11) as u64);
                    let v17 = *0x1::vector::borrow<u8>(v10, v11 + 1);
                    if (v17 != 0) {
                        while (v12 < v16) {
                            *0x1::vector::borrow_mut<u8>(&mut v1, v12) = v17 - 1 + (0x1::vector::length<u32>(&v0) as u8);
                            v12 = v12 + 1;
                        };
                    } else {
                        v12 = v16;
                    };
                    v11 = v11 + 2;
                };
            };
            0x1::vector::push_back<0x1::string::String>(&mut v2, slot_name(v7.slot));
            0x1::vector::push_back<0x1::string::String>(&mut v3, v7.name);
            v6 = v6 + 1;
        };
        let v18 = b"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 72 72'%3E%3Cimage width='72' height='72' style='image-rendering:pixelated' href='data:image/bmp;base64,";
        let v19 = &mut v18;
        let v20 = bmp_header(&v0);
        base64_into(v19, &v20);
        let v21 = &mut v18;
        base64_into(v21, &v1);
        let v22 = b"'/%3E%3C/svg%3E";
        0x1::vector::reverse<u8>(&mut v22);
        let v23 = 0;
        while (v23 < 0x1::vector::length<u8>(&v22)) {
            0x1::vector::push_back<u8>(&mut v18, 0x1::vector::pop_back<u8>(&mut v22));
            v23 = v23 + 1;
        };
        0x1::vector::destroy_empty<u8>(v22);
        (0x1::string::utf8(v18), v2, v3)
    }

    public fun has_layer(arg0: &Library, arg1: u16) : bool {
        0x2::table::contains<u16, Layer>(&arg0.layers, arg1)
    }

    public fun is_sealed(arg0: &Library) : bool {
        arg0.sealed
    }

    public fun new_library(arg0: &mut 0x2::tx_context::TxContext) : LibraryCap {
        let v0 = Library{
            id     : 0x2::object::new(arg0),
            layers : 0x2::table::new<u16, Layer>(arg0),
            sealed : false,
        };
        let v1 = LibraryCap{
            id      : 0x2::object::new(arg0),
            library : 0x2::object::id<Library>(&v0),
        };
        0x2::transfer::share_object<Library>(v0);
        v1
    }

    fun push_le32(arg0: &mut vector<u8>, arg1: u32) {
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24) as u8));
    }

    public fun seal(arg0: &mut Library, arg1: &LibraryCap) {
        assert!(arg1.library == 0x2::object::id<Library>(arg0), 13863768958173315075);
        assert!(!arg0.sealed, 13863206012514729985);
        arg0.sealed = true;
    }

    public fun slot_name(arg0: u8) : 0x1::string::String {
        let v0 = vector[b"Background", b"Skull", b"Apparel", b"Eyes", b"Hat", b"Teeth", b"Mouth"];
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, (arg0 as u64)))
    }

    // decompiled from Move bytecode v7
}

