module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog {
    struct CardMeta has copy, drop, store {
        card_id: 0x1::string::String,
        name: 0x1::string::String,
        image_slug: 0x1::string::String,
    }

    struct SetCatalog has key {
        id: 0x2::object::UID,
        version: u64,
        set_id: 0x1::string::String,
        pools: vector<vector<CardMeta>>,
        frozen: bool,
    }

    public fun add_card(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut SetCatalog, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        assert!(arg1.version == 1, 0);
        assert!(!arg1.frozen, 1);
        assert!((arg2 as u64) < 5, 3);
        assert!(!0x1::string::is_empty(&arg3) && !0x1::string::is_empty(&arg4), 2);
        let v0 = CardMeta{
            card_id    : arg3,
            name       : arg4,
            image_slug : arg5,
        };
        0x1::vector::push_back<CardMeta>(0x1::vector::borrow_mut<vector<CardMeta>>(&mut arg1.pools, (arg2 as u64)), v0);
    }

    public fun card_at(arg0: &SetCatalog, arg1: u64, arg2: u64) : CardMeta {
        *0x1::vector::borrow<CardMeta>(0x1::vector::borrow<vector<CardMeta>>(&arg0.pools, arg1), arg2)
    }

    public fun find(arg0: &SetCatalog, arg1: &0x1::string::String) : (bool, u64, CardMeta) {
        let v0 = 0;
        while (v0 < 5) {
            let v1 = 0x1::vector::borrow<vector<CardMeta>>(&arg0.pools, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<CardMeta>(v1)) {
                let v3 = 0x1::vector::borrow<CardMeta>(v1, v2);
                if (v3.card_id == *arg1) {
                    return (true, v0, *v3)
                };
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        let v4 = CardMeta{
            card_id    : 0x1::string::utf8(b""),
            name       : 0x1::string::utf8(b""),
            image_slug : 0x1::string::utf8(b""),
        };
        (false, 0, v4)
    }

    public fun freeze_catalog(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut SetCatalog) {
        assert!(arg1.version == 1, 0);
        assert!(0x1::vector::length<CardMeta>(0x1::vector::borrow<vector<CardMeta>>(&arg1.pools, 0)) > 0, 4);
        let v0 = 1;
        while (v0 < 5) {
            assert!(0x1::vector::length<CardMeta>(0x1::vector::borrow<vector<CardMeta>>(&arg1.pools, v0)) > 0, 5);
            v0 = v0 + 1;
        };
        arg1.frozen = true;
    }

    public fun is_frozen(arg0: &SetCatalog) : bool {
        arg0.frozen
    }

    public fun meta_card_id(arg0: &CardMeta) : 0x1::string::String {
        arg0.card_id
    }

    public fun meta_image(arg0: &CardMeta) : 0x1::string::String {
        arg0.image_slug
    }

    public fun meta_name(arg0: &CardMeta) : 0x1::string::String {
        arg0.name
    }

    public fun new_catalog(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<CardMeta>>();
        let v1 = 0;
        while (v1 < 5) {
            0x1::vector::push_back<vector<CardMeta>>(&mut v0, 0x1::vector::empty<CardMeta>());
            v1 = v1 + 1;
        };
        let v2 = SetCatalog{
            id      : 0x2::object::new(arg2),
            version : 1,
            set_id  : arg1,
            pools   : v0,
            frozen  : false,
        };
        0x2::transfer::share_object<SetCatalog>(v2);
    }

    public fun pool_len(arg0: &SetCatalog, arg1: u64) : u64 {
        0x1::vector::length<CardMeta>(0x1::vector::borrow<vector<CardMeta>>(&arg0.pools, arg1))
    }

    public fun rarity_label(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"C")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"R")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"E")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"L")
        } else {
            0x1::string::utf8(b"G")
        }
    }

    public fun set_id(arg0: &SetCatalog) : &0x1::string::String {
        &arg0.set_id
    }

    // decompiled from Move bytecode v7
}

