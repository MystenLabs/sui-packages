module 0xee9aec5a38da5613a0412791974eff83148f7f966cb5112c338d721ff64ce0ba::skin_store {
    struct Skin has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct StoreCap has store, key {
        id: 0x2::object::UID,
    }

    struct SKIN_STORE has drop {
        dummy_field: bool,
    }

    struct SKIN_INFO has store, key {
        id: 0x2::object::UID,
        skin_list: vector<0x1::string::String>,
        name_list: vector<0x1::string::String>,
        price_list: vector<u64>,
        gm: address,
    }

    public entry fun adminMint(arg0: &StoreCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Skin{
            id        : 0x2::object::new(arg3),
            name      : arg1,
            image_url : arg2,
        };
        0x2::transfer::public_transfer<Skin>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: SKIN_STORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suivision.xyz/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui jump jump skin: {name} ."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-jump-jump.vercel.app/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui jump jump"));
        let v4 = 0x2::package::claim<SKIN_STORE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Skin>(&v4, v0, v2, arg1);
        0x2::display::update_version<Skin>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/eJmLZ0QYcuI5KsbRjMnnTJwGJ-hcVbizVACM4HIpN3M"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/52tUM7ups1iN22nHp6IkeQwtAog_neNRajwM2aNXob4"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/OarbxLwnyFxFptBeuBR9vVZP1N8dqWFvg8UnAyQrCjs"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"recycleBottleJumper"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"catJumper"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"springJumper"));
        let v10 = SKIN_INFO{
            id         : 0x2::object::new(arg1),
            skin_list  : v6,
            name_list  : v8,
            price_list : vector[0, 1000000, 2000000],
            gm         : 0x2::tx_context::sender(arg1),
        };
        let v11 = StoreCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<SKIN_INFO>(v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Skin>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<StoreCap>(v11, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg3: &SKIN_INFO, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0x1::string::utf8(b"");
        let v3 = 0;
        let v4 = arg3.name_list;
        while (v0 < 0x1::vector::length<0x1::string::String>(&v4)) {
            let v5 = arg3.name_list;
            if (0x1::vector::borrow<0x1::string::String>(&v5, v0) == &arg0) {
                v2 = arg0;
                let v6 = arg3.skin_list;
                if (0x1::vector::borrow<0x1::string::String>(&v6, v0) == &arg1) {
                    v1 = arg1;
                };
                let v7 = arg3.price_list;
                let v8 = 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg2);
                if (0x1::vector::borrow<u64>(&v7, v0) == &v8) {
                    v3 = 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg2);
                };
            };
            v0 = v0 + 1;
        };
        assert!(v1 != 0x1::string::utf8(b""), 22);
        assert!(v2 != 0x1::string::utf8(b""), 22);
        assert!(0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg2) == v3, 11);
        let v9 = Skin{
            id        : 0x2::object::new(arg4),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>>(arg2, arg3.gm);
        0x2::transfer::public_transfer<Skin>(v9, 0x2::tx_context::sender(arg4));
    }

    public fun modifySkins(arg0: &StoreCap, arg1: &mut SKIN_INFO, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<u64>) {
        arg1.name_list = arg3;
        arg1.price_list = arg4;
        arg1.skin_list = arg2;
    }

    // decompiled from Move bytecode v6
}

