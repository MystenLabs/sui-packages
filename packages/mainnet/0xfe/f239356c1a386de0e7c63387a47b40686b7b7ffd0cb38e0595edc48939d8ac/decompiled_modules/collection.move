module 0xfef239356c1a386de0e7c63387a47b40686b7b7ffd0cb38e0595edc48939d8ac::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct MintData has store, key {
        id: 0x2::object::UID,
        minted: u64,
        base_name: 0x1::string::String,
        description: 0x1::string::String,
        base_url: 0x1::string::String,
        base_image_url: 0x1::string::String,
        limit_mint: u64,
    }

    struct Nikka has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MintCoinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<COLLECTION, Nikka>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v5 = Witness{dummy_field: false};
        let v6 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Nikka, Witness>(v5);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v8, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v9 = 0x2::display::new<Nikka>(&v4, arg1);
        0x2::display::add<Nikka>(&mut v9, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nikka>(&mut v9, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nikka>(&mut v9, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"https://{url}"));
        0x2::display::add<Nikka>(&mut v9, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://{image_url}"));
        0x2::display::add<Nikka>(&mut v9, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v7));
        0x2::display::update_version<Nikka>(&mut v9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Nikka, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Nikka Gear 5"), 0x1::string::utf8(b"A unique NFT collection of Nikka")));
        let v10 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v10, v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Nikka, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Nikka>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v10, vector[10000]), arg1), 1000, arg1);
        let (v11, v12) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Nikka>(&v4, arg1);
        let v13 = v12;
        let v14 = v11;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Nikka>(&mut v14, &v13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Nikka>(&mut v14, &v13);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Nikka>>(v2, v0);
        let v15 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v15, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nikka>>(v13, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Nikka>>(v9, 0x2::tx_context::sender(arg1));
        let v16 = MintData{
            id             : 0x2::object::new(arg1),
            minted         : 0,
            base_name      : 0x1::string::utf8(b"Nikka #"),
            description    : 0x1::string::utf8(b"NFT for X coin on Nikka. Monkey D.Luffy"),
            base_url       : 0x1::string::utf8(b"https://sui-pepe.xyz"),
            base_image_url : 0x1::string::utf8(b"https://api.sui-pepe.xyz/uploads/sui-pepe/"),
            limit_mint     : 3000,
        };
        0x2::transfer::public_share_object<MintData>(v16);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nikka>>(v14);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Nikka>>(v3);
    }

    public entry fun mint<T0: drop>(arg0: &mut MintData, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.minted + 1;
        assert!(v0 <= arg0.limit_mint, 403);
        let v1 = num_str(v0);
        let v2 = arg0.base_name;
        let v3 = arg0.base_image_url;
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v3, v1);
        0x1::string::append_utf8(&mut v3, b".webp");
        let v4 = Nikka{
            id          : 0x2::object::new(arg1),
            name        : v2,
            description : arg0.description,
            url         : arg0.base_url,
            image_url   : v3,
        };
        0x2::transfer::public_transfer<Nikka>(v4, 0x2::tx_context::sender(arg1));
        arg0.minted = arg0.minted + 1;
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

