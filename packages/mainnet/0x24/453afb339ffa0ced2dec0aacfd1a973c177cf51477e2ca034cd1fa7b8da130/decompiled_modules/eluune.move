module 0x24453afb339ffa0ced2dec0aacfd1a973c177cf51477e2ca034cd1fa7b8da130::eluune {
    struct ELUUNE has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Aurahma has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public entry fun airdrop_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Aurahma>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Aurahma>(arg6, v0, arg7);
    }

    public entry fun airdrop_nft_into_new_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Aurahma>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg6, arg7);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Aurahma>(&mut v3, v0, arg7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public fun burn_nft(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<Aurahma>, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Aurahma>, arg2: Aurahma) {
        let Aurahma {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
        } = arg2;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Aurahma>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Aurahma>(arg0, &arg2), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Aurahma>>(arg1), v0);
    }

    public entry fun burn_nft_in_listing(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Aurahma>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Aurahma>(arg0), arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft<Aurahma>(arg2, arg3, arg4));
    }

    public entry fun burn_nft_in_listing_with_id(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Aurahma>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Aurahma>(arg0), arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft_with_id<Aurahma>(arg2, arg3, arg4, arg5));
    }

    public entry fun burn_own_nft(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Aurahma>, arg1: Aurahma) {
        let v0 = Witness{dummy_field: false};
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Aurahma, Witness>(v0), arg0, arg1);
    }

    public entry fun burn_own_nft_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Aurahma>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Aurahma, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<Aurahma>(arg1, arg2, arg4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<Aurahma>(v1, arg3);
        burn_own_nft(arg0, v0);
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Aurahma, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Aurahma, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Aurahma>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Aurahma, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Aurahma, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Aurahma>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    fun init(arg0: ELUUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<ELUUNE, Aurahma>(&arg0, 0x1::option::some<u64>(600), arg1);
        let v2 = v0;
        let v3 = 0x2::package::claim<ELUUNE>(arg0, arg1);
        let v4 = 0x2::display::new<Aurahma>(&v3, arg1);
        0x2::display::add<Aurahma>(&mut v4, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Aurahma>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Aurahma>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Aurahma>(&mut v4, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Aurahma>(&mut v4, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(0x1::vector::empty<0x1::string::String>()));
        0x2::display::update_version<Aurahma>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Aurahma>>(v4, 0x2::tx_context::sender(arg1));
        let v5 = Witness{dummy_field: false};
        let v6 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Aurahma, Witness>(v5);
        let v7 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v7, @0x8212bb78cc5c42f95766107573147d79b0954fe06e52f54f27e26677b43c88f5);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Aurahma, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v6, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(v7));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Aurahma, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v6, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Eluune"), 0x1::string::utf8(b"Welcome to the exciting world of the Aurahma! These unique PFP NFTs showcase featured characters in the Project Eluune universe and are sacred Spirits of Eleriah. They are awakening as a result of humanity beginning to answer the Call of Eluune. Aurahma come in many forms, expressing themselves with an infinite number of special & rare traits from across this new frontier. By discovering one of these Aurahma, you are creating a meaningful connection, for every Aurahma contains within it an endless array of dormant powers yet to be unlocked.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Aurahma, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v6, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Aurahma, 0x2::url::Url>(v6, &mut v2, 0x2::url::new_unsafe_from_bytes(b""));
        let v8 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v8, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f, 500);
        0x2::vec_map::insert<address, u16>(&mut v8, @0x8212bb78cc5c42f95766107573147d79b0954fe06e52f54f27e26677b43c88f5, 9500);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Aurahma>(v6, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(v8, arg1), 700, arg1);
        let (v9, v10) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Aurahma>(&v3, arg1);
        let v11 = v10;
        let v12 = v9;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Aurahma>(&mut v12, &v11);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Aurahma>(&mut v12, &v11);
        let (v13, v14) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<Aurahma>(&v3, arg1);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Aurahma, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<Aurahma, 0x2::sui::SUI>(v6, &v12, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Aurahma>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Aurahma>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Aurahma>>(v11, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Aurahma>>(v12);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v14, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Aurahma, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v13);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Aurahma>, arg6: &mut 0x2::tx_context::TxContext) : Aurahma {
        let v0 = Aurahma{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Aurahma>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Aurahma, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Aurahma>(arg5), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Aurahma>(arg5, 1);
        v0
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Aurahma>, arg6: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<Aurahma>, arg7: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<Aurahma>(arg6, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7));
    }

    // decompiled from Move bytecode v6
}

