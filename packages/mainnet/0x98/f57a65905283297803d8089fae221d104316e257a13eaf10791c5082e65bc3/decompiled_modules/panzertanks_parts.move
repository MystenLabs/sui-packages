module 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct PANZERTANKS_PARTS has drop {
        dummy_field: bool,
    }

    struct Part<phantom T0> has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
        rarity: 0x1::string::String,
        level: u8,
    }

    struct Turret has copy, drop {
        dummy_field: bool,
    }

    struct Chassis has copy, drop {
        dummy_field: bool,
    }

    struct Tracks has copy, drop {
        dummy_field: bool,
    }

    struct Skin has copy, drop {
        dummy_field: bool,
    }

    public entry fun airdrop_part_to_kiosk<T0: copy + drop>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: u8, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Part<T0>>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_part_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8);
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Part<T0>>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Part<T0>, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Part<T0>>(arg7), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Part<T0>>(arg7, 1);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Part<T0>>(arg6, v0, arg8);
        0x2::object::id<Part<T0>>(&v0)
    }

    public fun borrow_part_name<T0: copy + drop>(arg0: &Part<T0>) : &0x1::string::String {
        &arg0.name
    }

    public fun borrow_part_uid<T0: copy + drop>(arg0: &Part<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun confirm_withdrawal<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::add_receipt<T0, Witness>(arg0, &v0);
    }

    fun create_collection<T0: copy + drop>(arg0: vector<address>, arg1: &PANZERTANKS_PARTS, arg2: &mut 0x2::tx_context::TxContext) : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Part<T0>> {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Part<T0>, Witness>(v0);
        let (v2, v3) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<PANZERTANKS_PARTS, Part<T0>>(arg1, 0x1::option::none<u64>(), arg2);
        let v4 = v2;
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Part<T0>, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v1, &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Panzerparts"), 0x1::string::utf8(b"Various types of parts to construct a tank with.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Part<T0>, 0x2::url::Url>(v1, &mut v4, 0x2::url::new_unsafe_from_bytes(b"https://panzerdogs.io/"));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Part<T0>, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v1, &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"PNZRPART")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Part<T0>, vector<0x1::string::String>>(v1, &mut v4, v5);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Part<T0>, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v1, &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&arg0)));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Part<T0>>>(v3, 0x2::tx_context::sender(arg2));
        v4
    }

    fun enforce_contract<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<T0>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<T0, Witness>(arg0, arg1);
    }

    fun init(arg0: PANZERTANKS_PARTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, @0xdf956a58a59fe2a9426a0310230a7c0dca7434843eec870d03d8b510ee6fe8aa);
        0x1::vector::push_back<address>(v2, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        let v3 = create_collection<Turret>(v1, &arg0, arg1);
        let v4 = create_collection<Chassis>(v1, &arg0, arg1);
        let v5 = create_collection<Tracks>(v1, &arg0, arg1);
        let v6 = create_collection<Skin>(v1, &arg0, arg1);
        let v7 = 0x2::package::claim<PANZERTANKS_PARTS>(arg0, arg1);
        setup_collection<Turret>(v3, &v7, v1, 0x1::string::utf8(b"turret"), arg1);
        setup_collection<Chassis>(v4, &v7, v1, 0x1::string::utf8(b"chassis"), arg1);
        setup_collection<Tracks>(v5, &v7, v1, 0x1::string::utf8(b"tracks"), arg1);
        setup_collection<Skin>(v6, &v7, v1, 0x1::string::utf8(b"skin"), arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, v0);
    }

    public fun mint_part<T0: copy + drop>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: u8, arg6: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Part<T0>>, arg7: &mut 0x2::tx_context::TxContext) : Part<T0> {
        let v0 = mint_part_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Part<T0>>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Part<T0>, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Part<T0>>(arg6), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Part<T0>>(arg6, 1);
        v0
    }

    fun mint_part_internal<T0: copy + drop>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : Part<T0> {
        0x1::vector::reverse<0x1::ascii::String>(&mut arg2);
        0x1::vector::reverse<0x1::ascii::String>(&mut arg3);
        Part<T0>{
            id         : 0x2::object::new(arg6),
            game_id    : arg0,
            name       : arg1,
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg2, arg3),
            rarity     : arg4,
            level      : arg5,
        }
    }

    public entry fun multi_airdrop_part_to_kiosk<T0: copy + drop>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: 0x1::string::String, arg5: u8, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Part<T0>>, arg9: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x1::vector::empty<Part<T0>>();
        while (v0 < arg6) {
            let v3 = mint_part_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
            let v4 = Witness{dummy_field: false};
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Part<T0>>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Part<T0>, Witness>(v4), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Part<T0>>(arg8), &v3);
            0x1::vector::push_back<Part<T0>>(&mut v2, v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<Part<T0>>(&v3));
            v0 = v0 + 1;
        };
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit_batch<Part<T0>>(arg7, v2, arg9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Part<T0>>(arg8, arg6);
        v1
    }

    public entry fun mutate_parts_url<T0: copy + drop>(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::display::Display<Part<T0>>) {
        assert!(0x2::display::is_authorized<Part<T0>>(arg0), 2);
        0x2::display::edit<Part<T0>>(arg2, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Part<T0>>(arg2);
    }

    fun setup_collection<T0: copy + drop>(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Part<T0>>, arg1: &0x2::package::Publisher, arg2: vector<address>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"A part to construct your tank with."));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        0x1::vector::push_back<0x1::string::String>(v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v8 = 0x2::display::new_with_fields<Part<T0>>(arg1, v2, v4, arg4);
        let v9 = 0x1::string::utf8(b"ipfs://QmboRMjYWntuzgRS5ztkMS5fYBR7D5cGhJjMxRXZQgVK8u/");
        0x1::string::append(&mut v9, arg3);
        0x1::string::append(&mut v9, 0x1::string::utf8(b"/{game_id}.png"));
        0x2::display::add<Part<T0>>(&mut v8, 0x1::string::utf8(b"image_url"), v9);
        0x2::display::add<Part<T0>>(&mut v8, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v6));
        0x2::display::update_version<Part<T0>>(&mut v8);
        let (v10, v11) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Part<T0>>(arg1, arg4);
        let v12 = v11;
        let v13 = v10;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Part<T0>>(&mut v13, &v12);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Part<T0>>(&mut v13, &v12);
        let (v14, v15) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<Part<T0>>(arg1, arg4);
        let v16 = v15;
        let v17 = v14;
        let v18 = &mut v17;
        enforce_contract<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Part<T0>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>(v18, &v16);
        let (v19, v20) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::init_policy<Part<T0>>(arg1, arg4);
        let (v21, v22) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Part<T0>>(arg1, arg4);
        let v23 = v22;
        let v24 = v21;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<Part<T0>>(&mut v24, &v23);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Part<T0>>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Part<T0>, Witness>(v0), &mut arg0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(arg2, vector[9600, 400]), arg4), 500, arg4);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Part<T0>>>(arg0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Part<T0>>>(v23, v1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Part<T0>>>(v24);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Part<T0>>>(v12, v1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Part<T0>>>(v13);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v16, v1);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Part<T0>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v17);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v20, v1);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Part<T0>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>>(v19);
        0x2::transfer::public_transfer<0x2::display::Display<Part<T0>>>(v8, v1);
    }

    // decompiled from Move bytecode v6
}

