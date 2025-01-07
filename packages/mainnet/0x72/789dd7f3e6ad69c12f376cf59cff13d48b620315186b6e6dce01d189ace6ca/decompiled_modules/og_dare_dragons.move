module 0x72789dd7f3e6ad69c12f376cf59cff13d48b620315186b6e6dce01d189ace6ca::og_dare_dragons {
    struct OG_DARE_DRAGONS has drop {
        dummy_field: bool,
    }

    struct OGDareDragon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    fun mint(arg0: &mut 0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::MintCap<OGDareDragon>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : OGDareDragon {
        let v0 = OGDareDragon{
            id    : 0x2::object::new(arg3),
            name  : arg1,
            image : arg2,
        };
        0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::mint<OGDareDragon>(arg0, 0x2::object::id<OGDareDragon>(&v0));
        v0
    }

    fun init(arg0: OG_DARE_DRAGONS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OG_DARE_DRAGONS>(arg0, arg1);
        let v1 = 0x2::display::new<OGDareDragon>(&v0, arg1);
        0x2::display::add<OGDareDragon>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<OGDareDragon>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"OG Dare Dragons"));
        0x2::display::add<OGDareDragon>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The 99 most degenerate dragons in the universe"));
        0x2::display::add<OGDareDragon>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::add<OGDareDragon>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://daredragons.com"));
        0x2::display::update_version<OGDareDragon>(&mut v1);
        let v2 = 0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_proportional_rule::new<0xcfd609dedf573a72981504554ec737f6e09ddfeec3ff9927bd135b82566a5d2b::orderbook_kiosk::OrderbookRoyaltyWitness>(0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_share::from_address(@0xfb7a778200a58bf5f407857562d4f5f3d7034b545d50d52fb2199c24c5cdbf5), 500, arg1);
        let (v3, v4) = 0x2::transfer_policy::new<OGDareDragon>(&v0, arg1);
        let v5 = v4;
        let v6 = v3;
        0xcfd609dedf573a72981504554ec737f6e09ddfeec3ff9927bd135b82566a5d2b::orderbook_rule::add<OGDareDragon>(&mut v6, &v5);
        0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_proportional_rule::add<0xcfd609dedf573a72981504554ec737f6e09ddfeec3ff9927bd135b82566a5d2b::orderbook_kiosk::OrderbookRoyaltyWitness, OGDareDragon>(&mut v6, &v5, &v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<OGDareDragon>(&mut v6, &v5);
        0x2::transfer::public_transfer<0x2::display::Display<OGDareDragon>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::MintCap<OGDareDragon>>(0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::new<OG_DARE_DRAGONS, OGDareDragon>(&arg0, 99, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<OGDareDragon>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<OGDareDragon>>(v6);
        0x2::transfer::public_share_object<0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_proportional_rule::RoyaltyProportional<0xcfd609dedf573a72981504554ec737f6e09ddfeec3ff9927bd135b82566a5d2b::orderbook_kiosk::OrderbookRoyaltyWitness>>(v2);
    }

    public entry fun mint_to_address(arg0: &mut 0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::MintCap<OGDareDragon>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg4);
        let (v1, v2) = 0x2::kiosk::new(arg4);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::set_owner_custom(&mut v4, &v3, arg3);
        0x2::kiosk::place<OGDareDragon>(&mut v4, &v3, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
    }

    // decompiled from Move bytecode v6
}

