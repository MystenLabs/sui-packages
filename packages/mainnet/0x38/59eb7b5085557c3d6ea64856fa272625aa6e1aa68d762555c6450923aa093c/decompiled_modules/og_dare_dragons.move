module 0x3859eb7b5085557c3d6ea64856fa272625aa6e1aa68d762555c6450923aa093c::og_dare_dragons {
    struct OG_DARE_DRAGONS has drop {
        dummy_field: bool,
    }

    struct OGDareDragon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    fun init(arg0: OG_DARE_DRAGONS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OG_DARE_DRAGONS>(arg0, arg1);
        let v1 = 0x2::display::new<OGDareDragon>(&v0, arg1);
        0x2::display::add<OGDareDragon>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<OGDareDragon>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"99 of the most degenerate dragons in the universe"));
        0x2::display::add<OGDareDragon>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::add<OGDareDragon>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://daredragons.com"));
        0x2::display::update_version<OGDareDragon>(&mut v1);
        let (v2, v3) = 0x38e22fbd93ef46b0c10aeb84ea5c784aa22b6e3c6aa1e1f79a40c019d2783c72::airdrop::new(arg1);
        let v4 = v2;
        let v5 = 0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse_pseudorandom::new<OGDareDragon>(arg1);
        let (v6, v7) = 0x2::transfer_policy::new<OGDareDragon>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse_pseudorandom_rule::add_withdraw<OGDareDragon>(&mut v9, &v8, &v5);
        0x38e22fbd93ef46b0c10aeb84ea5c784aa22b6e3c6aa1e1f79a40c019d2783c72::airdrop_rule::add<OGDareDragon>(&mut v9, &v8, &v4);
        let v10 = 0x94f27d71ea24cadaf37956c0a77ca1c59561cbf9ff08ead7e990059a8584713c::royalty_proportional_rule::new(0x94f27d71ea24cadaf37956c0a77ca1c59561cbf9ff08ead7e990059a8584713c::royalty_share::from_address(@0x25565), 100, arg1);
        let (v11, v12) = 0x2::transfer_policy::new<OGDareDragon>(&v0, arg1);
        let v13 = v12;
        let v14 = v11;
        0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_rule::add<OGDareDragon>(&mut v14, &v13);
        0x94f27d71ea24cadaf37956c0a77ca1c59561cbf9ff08ead7e990059a8584713c::royalty_proportional_rule::add<OGDareDragon>(&mut v14, &v13, &v10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<OGDareDragon>(&mut v14, &v13);
        0x2::transfer::public_transfer<0x2::display::Display<OGDareDragon>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x8cad6e5e2938274f9e2862f87e59e6b88f1bd2fcef279ce82c3a194669c109d5::mint_cap::MintCap<OGDareDragon>>(0x8cad6e5e2938274f9e2862f87e59e6b88f1bd2fcef279ce82c3a194669c109d5::mint_cap::new<OG_DARE_DRAGONS, OGDareDragon>(&arg0, 99, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x38e22fbd93ef46b0c10aeb84ea5c784aa22b6e3c6aa1e1f79a40c019d2783c72::airdrop::AirdropCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<OGDareDragon>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<OGDareDragon>>(v13, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x38e22fbd93ef46b0c10aeb84ea5c784aa22b6e3c6aa1e1f79a40c019d2783c72::airdrop::Airdrop>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<OGDareDragon>>(v9);
        0x2::transfer::public_share_object<0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse_pseudorandom::WarehousePseudorandom<OGDareDragon>>(v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<OGDareDragon>>(v14);
        0x2::transfer::public_share_object<0x94f27d71ea24cadaf37956c0a77ca1c59561cbf9ff08ead7e990059a8584713c::royalty_proportional_rule::RoyaltyProportional>(v10);
    }

    fun mint(arg0: &mut 0x8cad6e5e2938274f9e2862f87e59e6b88f1bd2fcef279ce82c3a194669c109d5::mint_cap::MintCap<OGDareDragon>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : OGDareDragon {
        let v0 = OGDareDragon{
            id    : 0x2::object::new(arg3),
            name  : arg1,
            image : arg2,
        };
        0x8cad6e5e2938274f9e2862f87e59e6b88f1bd2fcef279ce82c3a194669c109d5::mint_cap::mint<OGDareDragon>(arg0, 0x2::object::id<OGDareDragon>(&v0));
        v0
    }

    public entry fun mint_to_warehouse(arg0: &mut 0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse_pseudorandom::WarehousePseudorandom<OGDareDragon>, arg1: &mut 0x8cad6e5e2938274f9e2862f87e59e6b88f1bd2fcef279ce82c3a194669c109d5::mint_cap::MintCap<OGDareDragon>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse_pseudorandom::deposit<OGDareDragon>(arg0, mint(arg1, arg2, arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

