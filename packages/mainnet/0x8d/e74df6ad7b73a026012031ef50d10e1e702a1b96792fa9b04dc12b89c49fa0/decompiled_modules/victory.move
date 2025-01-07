module 0x8de74df6ad7b73a026012031ef50d10e1e702a1b96792fa9b04dc12b89c49fa0::victory {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Victory has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct VICTORY has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_from_otw<VICTORY, Victory>(&arg0, arg1);
        let v2 = 0x2::package::claim<VICTORY>(arg0, arg1);
        let v3 = Witness{dummy_field: false};
        let v4 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Victory, Witness>(v3);
        init_display(&v2, arg1);
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Victory, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v4, &mut v1, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v5)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Victory>(v4, &mut v1, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v5, vector[10000]), arg1), 300, arg1);
        let (v6, v7) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Victory>(&v2, arg1);
        let v8 = v7;
        let v9 = v6;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Victory>(&mut v9, &v8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Victory>(&mut v9, &v8);
        0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::share<Victory, 0x2::sui::SUI>(0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::new_with_protected_actions<Victory, 0x2::sui::SUI>(v4, &v9, 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::custom_protection(true, true, true), arg1));
        let v10 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Victory>>(v8, v0);
        0x2::transfer::public_transfer<OwnerCap>(v10, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Victory>>(v1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Victory>>(v9);
    }

    fun init_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<Victory>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        0x2::display::add<Victory>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Victory>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Victory NFT"));
        0x2::display::add<Victory>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Victory>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Victory>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://victory.io"));
        0x2::display::add<Victory>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"victory.io"));
        0x2::display::add<Victory>(&mut v0, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v1));
        0x2::display::update_version<Victory>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<Victory>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &OwnerCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Victory{
            id         : 0x2::object::new(arg7),
            name       : 0x1::string::utf8(arg1),
            image_url  : 0x2::url::new_unsafe_from_bytes(arg2),
            url        : 0x2::url::new_unsafe_from_bytes(arg3),
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg4, arg5),
        };
        let (v1, v2) = 0x2::kiosk::new(arg7);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::set_owner_custom(&mut v4, &v3, arg6);
        0x2::kiosk::place<Victory>(&mut v4, &v3, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
    }

    // decompiled from Move bytecode v6
}

