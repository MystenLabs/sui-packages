module 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::avatars {
    struct AVATARS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Avatar has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        rarity_score: 0x1::string::String,
        generation: 0x1::string::String,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public entry fun attach_equipment<T0: store + key>(arg0: &mut Avatar, arg1: T0, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::compose_into_nft<Avatar, T0>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<Avatar>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Avatar>(arg2)), &mut arg0.id, arg1);
    }

    public entry fun attach_equipment_from_other_kiosk<T0: store + key>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Avatar, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<Avatar>(arg2, arg4, 0x1::option::none<0x1::type_name::TypeName>(), arg7);
        let v2 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, Avatar>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Avatar, Witness>(v0), &mut v1);
        let (v3, v4) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(arg3, arg5, arg7);
        let v5 = v4;
        0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::confirm_withdrawal<T0>(&mut v5);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<T0>(v5, arg1);
        attach_equipment<T0>(v2, v3, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, Avatar>(arg2, v1, arg0);
    }

    public entry fun attach_equipment_from_same_kiosk<T0: store + key>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Avatar, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<Avatar>(arg2, arg3, 0x1::option::none<0x1::type_name::TypeName>(), arg6);
        let v2 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, Avatar>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Avatar, Witness>(v0), &mut v1);
        let (v3, v4) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(arg2, arg4, arg6);
        let v5 = v4;
        0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::confirm_withdrawal<T0>(&mut v5);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<T0>(v5, arg1);
        attach_equipment<T0>(v2, v3, arg5);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, Avatar>(arg2, v1, arg0);
    }

    fun burn_avatar(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<Avatar>, arg1: Avatar, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>) {
        let Avatar {
            id           : v0,
            name         : _,
            description  : _,
            image_url    : _,
            rarity       : _,
            rarity_score : _,
            generation   : _,
            attributes   : _,
        } = arg1;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Avatar>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Avatar>(arg0, &arg1), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>>(arg2), v0);
    }

    public entry fun burn_avatar_in_listing(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        burn_avatar(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Avatar>(arg0), 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft<Avatar>(arg2, arg3, arg4), arg1);
    }

    public entry fun burn_avatar_in_listing_with_id(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        burn_avatar(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Avatar>(arg0), 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft_with_id<Avatar>(arg2, arg3, arg4, arg5), arg1);
    }

    public entry fun burn_own_avatar(arg0: Avatar, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>) {
        let v0 = Witness{dummy_field: false};
        burn_avatar(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Avatar, Witness>(v0), arg0, arg1);
    }

    public entry fun burn_own_avatar_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Avatar, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<Avatar>(arg1, arg2, arg4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<Avatar>(v1, arg3);
        burn_own_avatar(v0, arg0);
    }

    public entry fun detach_equipment<T0: store + key>(arg0: &mut Avatar, arg1: 0x2::object::ID, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(arg3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::decompose_from_nft<Avatar, T0>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::borrow_domain<Avatar>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid<Avatar>(arg2)), &mut arg0.id, arg1), arg4);
    }

    public entry fun detach_equipment_to_kiosk<T0: store + key>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Avatar, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<Avatar>(arg1, arg2, 0x1::option::none<0x1::type_name::TypeName>(), arg5);
        let v2 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, Avatar>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Avatar, Witness>(v0), &mut v1);
        detach_equipment<T0>(v2, arg3, arg4, arg1, arg5);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, Avatar>(arg1, v1, arg0);
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Avatar, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Avatar, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Avatar>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Avatar, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Avatar, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Avatar>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    fun init(arg0: AVATARS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Witness{dummy_field: false};
        let v2 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Avatar, Witness>(v1);
        let v3 = 0x1::vector::empty<address>();
        let v4 = &mut v3;
        0x1::vector::push_back<address>(v4, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x1::vector::push_back<address>(v4, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        let (v5, v6) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<AVATARS, Avatar>(&arg0, 0x1::option::some<u64>(11111), arg1);
        let v7 = v5;
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Avatar>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::new_unlimited<AVATARS, Avatar>(&arg0, 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>>(&v7), arg1), @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        let v8 = 0x2::package::claim<AVATARS>(arg0, arg1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Avatar, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v2, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Cosmocadia Avatars"), 0x1::string::utf8(b"A play & earn community-based farming game on the Sui network by Lucky Kat Studios. This collection contains avatar NFTs.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Avatar, 0x2::url::Url>(v2, &mut v7, 0x2::url::new_unsafe_from_bytes(b"https://cosmocadia.io/"));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Avatar, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v2, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v3)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Avatar, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v2, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"COSMO")));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"rarity_score"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"generation"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"attributes"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://cosmocadia.io"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Lucky Kat Studios"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{rarity_score}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{generation}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{attributes}"));
        let v13 = 0x1::vector::empty<0x1::string::String>();
        let v14 = &mut v13;
        0x1::vector::push_back<0x1::string::String>(v14, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v14, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::profile_picture());
        0x1::vector::push_back<0x1::string::String>(v14, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        0x1::vector::push_back<0x1::string::String>(v14, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v15 = 0x2::display::new_with_fields<Avatar>(&v8, v9, v11, arg1);
        0x2::display::add<Avatar>(&mut v15, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v13));
        0x2::display::update_version<Avatar>(&mut v15);
        let (v16, v17) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Avatar>(&v8, arg1);
        let v18 = v17;
        let v19 = v16;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Avatar>(&mut v19, &v18);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Avatar>(&mut v19, &v18);
        let (v20, v21) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::init_policy<Avatar>(&v8, arg1);
        let (v22, v23) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Avatar>(&v8, arg1);
        let v24 = v23;
        let v25 = v22;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<Avatar>(&mut v25, &v24);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Avatar, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<Avatar, 0x2::sui::SUI>(v2, &v19, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Avatar>(v2, &mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v3, vector[9600, 400]), arg1), 500, arg1);
        let v26 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::new_composition<Avatar>();
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Avatar, 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::Back>(&mut v26, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Avatar, 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::Bottom>(&mut v26, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Avatar, 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::Eyes>(&mut v26, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Avatar, 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::Head>(&mut v26, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Avatar, 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::Misc>(&mut v26, 2);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Avatar, 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::Mouth>(&mut v26, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Avatar, 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::Neck>(&mut v26, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Avatar, 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::Skin>(&mut v26, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::add_relationship<Avatar, 0xc4a577f477311395c4fef094ef4fc39ffabb86ddf0386677dcb09a6799257aad::equipment::Top>(&mut v26, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Avatar, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::composable_nft::Composition<Avatar>>(v2, &mut v7, v26);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Avatar>>(v6, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Avatar>>(v15, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Avatar>>(v18, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Avatar>>(v19);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v21, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Avatar, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>>(v20);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Avatar>>(v24, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Avatar>>(v25);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Avatar>>(v7);
    }

    fun mint_avatar(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Avatar>, arg8: &mut 0x2::tx_context::TxContext) : Avatar {
        let v0 = Avatar{
            id           : 0x2::object::new(arg8),
            name         : 0x1::string::utf8(arg0),
            description  : 0x1::string::utf8(arg1),
            image_url    : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity       : 0x1::string::utf8(arg3),
            rarity_score : 0x1::string::utf8(arg4),
            generation   : 0x1::string::utf8(b"Gen 1"),
            attributes   : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg5, arg6),
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::add_domain(&mut v0.id, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::new(arg8));
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Avatar>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Avatar, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Avatar>(arg7), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Avatar>(arg7, 1);
        v0
    }

    public entry fun mint_avatar_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Avatar>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Avatar>(mint_avatar(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9), arg8);
    }

    public entry fun mint_avatar_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Avatar>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_avatar(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Avatar>(arg8, v0, arg9);
        0x2::object::id<Avatar>(&v0)
    }

    public entry fun mint_avatar_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Avatar>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_avatar(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg8, arg9);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Avatar>(&mut v3, v0, arg9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public entry fun mint_avatar_to_warehouse(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Avatar>, arg8: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<Avatar>, arg9: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<Avatar>(arg8, mint_avatar(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9));
    }

    public entry fun update_avatar(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Avatar, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg7: &0x2::package::Publisher, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<Avatar>(arg0, arg1, 0x1::option::none<0x1::type_name::TypeName>(), arg8);
        let v1 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, Avatar>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Avatar>(arg7), &mut v0);
        v1.description = 0x1::string::utf8(arg2);
        v1.image_url = 0x2::url::new_unsafe_from_bytes(arg3);
        v1.attributes = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg4, arg5);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, Avatar>(arg0, v0, arg6);
    }

    // decompiled from Move bytecode v6
}

