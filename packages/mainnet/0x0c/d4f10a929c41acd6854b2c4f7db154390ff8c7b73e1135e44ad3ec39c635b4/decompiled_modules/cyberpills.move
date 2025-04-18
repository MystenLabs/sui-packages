module 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::cyberpills {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct CYBERPILLS has drop {
        dummy_field: bool,
    }

    struct Cyberpill has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public entry fun airdrop_pill_to_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cyberpill>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Cyberpill{
            id         : 0x2::object::new(arg6),
            game_id    : arg0,
            name       : arg1,
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg2, arg3),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Cyberpill>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Cyberpill, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Cyberpill>(arg4), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Cyberpill>(arg4, 1);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Cyberpill>(arg5, v0, arg6);
    }

    public fun borrow_pill_name(arg0: &Cyberpill) : &0x1::string::String {
        &arg0.name
    }

    public fun borrow_pill_uid(arg0: &Cyberpill) : &0x2::object::UID {
        &arg0.id
    }

    public fun create_new_mint_cap(arg0: &0x2::package::Publisher, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cyberpill>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::display::is_authorized<Cyberpill>(arg0), 0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cyberpill>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::split<Cyberpill>(arg1, arg2, arg4), arg3);
    }

    fun enforce_contract<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<T0>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<T0, Witness>(arg0, arg1);
    }

    fun init(arg0: CYBERPILLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, @0xdf956a58a59fe2a9426a0310230a7c0dca7434843eec870d03d8b510ee6fe8aa);
        0x1::vector::push_back<address>(v2, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        let v3 = Witness{dummy_field: false};
        let v4 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Cyberpill, Witness>(v3);
        let (v5, v6) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<CYBERPILLS, Cyberpill>(&arg0, 0x1::option::none<u64>(), arg1);
        let v7 = v5;
        let v8 = 0x2::package::claim<CYBERPILLS>(arg0, arg1);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"creator"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"ipfs://Qma2taG5TePBxiw3zEhU3zCdXyfFB6aRsTNmPChsBbkWwV/{game_id}.gif"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v13 = 0x2::display::new_with_fields<Cyberpill>(&v8, v9, v11, arg1);
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::string::String>(v15, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        0x1::vector::push_back<0x1::string::String>(v15, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        0x2::display::add<Cyberpill>(&mut v13, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v14));
        0x2::display::update_version<Cyberpill>(&mut v13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Cyberpill, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Cyberpills"), 0x1::string::utf8(b"Cybernetic enhancement pills used to combine two Panzerdogs")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Cyberpill, 0x2::url::Url>(v4, &mut v7, 0x2::url::new_unsafe_from_bytes(b"https://www.panzerdogs.io/"));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Cyberpill, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"CYBERPILL")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Cyberpill, vector<0x1::string::String>>(v4, &mut v7, v14);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Cyberpill, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v1)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Cyberpill>(v4, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v1, vector[9600, 400]), arg1), 500, arg1);
        let (v16, v17) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Cyberpill>(&v8, arg1);
        let v18 = v17;
        let v19 = v16;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Cyberpill>(&mut v19, &v18);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Cyberpill>(&mut v19, &v18);
        let (v20, v21) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<Cyberpill>(&v8, arg1);
        let v22 = v21;
        let v23 = v20;
        let v24 = &mut v23;
        enforce_contract<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Cyberpill, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>(v24, &v22);
        let (v25, v26) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::init_policy<Cyberpill>(&v8, arg1);
        let (v27, v28) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Cyberpill>(&v8, arg1);
        let v29 = v28;
        let v30 = v27;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<Cyberpill>(&mut v30, &v29);
        0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier::create_signer(&v8, arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cyberpill>>(v6, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Cyberpill>>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Cyberpill>>(v13, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Cyberpill>>(v29, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Cyberpill>>(v30);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Cyberpill>>(v18, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Cyberpill>>(v19);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v22, v0);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Cyberpill, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v23);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v26, v0);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Cyberpill, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>>(v25);
    }

    public entry fun mint_cyberpill(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cyberpill>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Cyberpill{
            id         : 0x2::object::new(arg6),
            game_id    : arg0,
            name       : arg1,
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg2, arg3),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Cyberpill>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Cyberpill, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Cyberpill>(arg4), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Cyberpill>(arg4, 1);
        0x2::transfer::public_transfer<Cyberpill>(v0, arg5);
    }

    public entry fun mutate_cyberpill_url(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::display::Display<Cyberpill>) {
        assert!(0x2::display::is_authorized<Cyberpill>(arg0), 0);
        0x2::display::edit<Cyberpill>(arg2, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Cyberpill>(arg2);
    }

    // decompiled from Move bytecode v6
}

