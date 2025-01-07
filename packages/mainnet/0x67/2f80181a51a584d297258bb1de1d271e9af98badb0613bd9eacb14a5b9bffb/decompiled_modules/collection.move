module 0x672f80181a51a584d297258bb1de1d271e9af98badb0613bd9eacb14a5b9bffb::collection {
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

    struct Phase has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        mint_price: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AddPhaseEvent has copy, drop {
        id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
        mint_price: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_phase<T0: drop>(arg0: &mut AdminCap, arg1: &mut MintData, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = Phase{
            id         : v1,
            start_time : arg2,
            end_time   : arg3,
            mint_price : arg4,
            coin_type  : v0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Phase>(&mut arg1.id, v2, v3);
        let v4 = AddPhaseEvent{
            id         : v2,
            start_time : arg2,
            end_time   : arg3,
            mint_price : arg4,
            coin_type  : v0,
        };
        0x2::event::emit<AddPhaseEvent>(v4);
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

    public entry fun mint<T0: drop>(arg0: &mut MintData, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.minted + 1;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1) == true, 405);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Phase>(&arg0.id, arg1);
        assert!(v0 <= arg0.limit_mint, 403);
        assert!(v2.end_time >= v1, 406);
        assert!(v2.start_time <= v1, 406);
        assert!(0x1::type_name::get<T0>() == v2.coin_type, 407);
        assert!(arg3 == v2.mint_price, 404);
        let v3 = CoinKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<CoinKey>(&arg0.id, v3)) {
            let v4 = CoinKey{dummy_field: false};
            0x2::dynamic_object_field::add<CoinKey, 0x2::coin::Coin<T0>>(&mut arg0.id, v4, 0x2::coin::split<T0>(arg2, arg3, arg5));
        } else {
            let v5 = CoinKey{dummy_field: false};
            0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<CoinKey, 0x2::coin::Coin<T0>>(&mut arg0.id, v5), 0x2::coin::split<T0>(arg2, arg3, arg5));
        };
        let v6 = num_str(v0);
        let v7 = arg0.base_name;
        let v8 = arg0.base_image_url;
        0x1::string::append(&mut v7, v6);
        0x1::string::append(&mut v8, v6);
        0x1::string::append_utf8(&mut v8, b".webp");
        let v9 = Nikka{
            id          : 0x2::object::new(arg5),
            name        : v7,
            description : arg0.description,
            url         : arg0.base_url,
            image_url   : v8,
        };
        0x2::transfer::public_transfer<Nikka>(v9, 0x2::tx_context::sender(arg5));
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

    public entry fun withdraw<T0: drop>(arg0: &mut AdminCap, arg1: &mut MintData, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_object_field::remove<CoinKey, 0x2::coin::Coin<T0>>(&mut arg1.id, v0), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

