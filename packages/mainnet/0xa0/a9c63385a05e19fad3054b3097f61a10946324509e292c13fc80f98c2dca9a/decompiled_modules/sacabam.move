module 0xa0a9c63385a05e19fad3054b3097f61a10946324509e292c13fc80f98c2dca9a::sacabam {
    struct SACABAM has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Sacabam has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct Inventory has store, key {
        id: 0x2::object::UID,
        revelation: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        revealed: 0x2::table::Table<0x2::object::ID, bool>,
        warehouse: 0xa0a9c63385a05e19fad3054b3097f61a10946324509e292c13fc80f98c2dca9a::warehouse::Warehouse<Sacabam>,
    }

    struct Redeem has copy, drop {
        fossil_id: 0x2::object::ID,
        sacabam_id: 0x2::object::ID,
        sender: address,
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Sacabam, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Sacabam, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Sacabam>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Sacabam, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Sacabam, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Sacabam>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    fun init(arg0: SACABAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<SACABAM, Sacabam>(&arg0, 0x1::option::some<u64>(3333), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<SACABAM>(arg0, arg1);
        let v5 = 0x2::display::new<Sacabam>(&v4, arg1);
        0x2::display::add<Sacabam>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Sacabam>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Sacabam>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Sacabam>(&mut v5, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Sacabam>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Sacabam>>(v5, v0);
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Sacabam, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Sacabam, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x2::vec_set::singleton<address>(v0)));
        let v7 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Sacabam>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Sacabam, Witness>(v7), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x2::vec_map::empty<address, u16>(), arg1), 0, arg1);
        let (v8, v9) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Sacabam>(&v4, arg1);
        let v10 = v9;
        let v11 = v8;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Sacabam>(&mut v11, &v10);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Sacabam>(&mut v11, &v10);
        let v12 = Witness{dummy_field: false};
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Sacabam, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<Sacabam, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Sacabam, Witness>(v12), &v11, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        let (v13, v14) = 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new(arg1);
        let v15 = v14;
        let v16 = v13;
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Witness>(&v15, &mut v16);
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::Witness>(&v15, &mut v16);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Sacabam>>(v2, v0);
        0x2::transfer::public_transfer<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(v15, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Sacabam>>(v10, v0);
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(v16);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Sacabam>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Sacabam>>(v11);
        let v17 = Inventory{
            id         : 0x2::object::new(arg1),
            revelation : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            revealed   : 0x2::table::new<0x2::object::ID, bool>(arg1),
            warehouse  : 0xa0a9c63385a05e19fad3054b3097f61a10946324509e292c13fc80f98c2dca9a::warehouse::new<Sacabam>(arg1),
        };
        0x2::transfer::public_share_object<Inventory>(v17);
    }

    public entry fun mint_nft(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Sacabam>, arg1: &mut Inventory, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = Sacabam{
            id          : 0x2::object::new(arg7),
            name        : arg2,
            description : arg3,
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg5, arg6),
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Sacabam>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Sacabam, Witness>(v0), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Sacabam>(arg0), &v1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Sacabam>(arg0, 1);
        0xa0a9c63385a05e19fad3054b3097f61a10946324509e292c13fc80f98c2dca9a::warehouse::deposit_nft<Sacabam>(&mut arg1.warehouse, v1);
    }

    public entry fun redeem_nft(arg0: &mut Inventory, arg1: &0x5a906c0c895ba8d6c8ee57a07f79beffb813523a84c2dd8c715b57ba0b4f9865::fossil::BurnCap, arg2: &mut 0x5a906c0c895ba8d6c8ee57a07f79beffb813523a84c2dd8c715b57ba0b4f9865::supply::Supply, arg3: 0x5a906c0c895ba8d6c8ee57a07f79beffb813523a84c2dd8c715b57ba0b4f9865::fossil::Fossil, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x5a906c0c895ba8d6c8ee57a07f79beffb813523a84c2dd8c715b57ba0b4f9865::fossil::Fossil>(&arg3);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.revelation, v0), 2);
        0x5a906c0c895ba8d6c8ee57a07f79beffb813523a84c2dd8c715b57ba0b4f9865::fossil::burn(arg1, arg2, arg3, arg5);
        let v1 = *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.revelation, v0);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Sacabam>(arg4, 0xa0a9c63385a05e19fad3054b3097f61a10946324509e292c13fc80f98c2dca9a::warehouse::redeem_nft<Sacabam>(&mut arg0.warehouse, v1), arg5);
        let v2 = Redeem{
            fossil_id  : v0,
            sacabam_id : v1,
            sender     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Redeem>(v2);
    }

    public entry fun reveal(arg0: &0x2::package::Publisher, arg1: &mut Inventory, arg2: vector<0x2::object::ID>, arg3: vector<0x2::object::ID>) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<0x2::object::ID>(&arg3), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v0);
            0xa0a9c63385a05e19fad3054b3097f61a10946324509e292c13fc80f98c2dca9a::warehouse::assert_exists<Sacabam>(&arg1.warehouse, v2);
            assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg1.revelation, v1) && !0x2::table::contains<0x2::object::ID, bool>(&arg1.revealed, v2), 1);
            0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.revelation, v1, v2);
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.revealed, v2, true);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

