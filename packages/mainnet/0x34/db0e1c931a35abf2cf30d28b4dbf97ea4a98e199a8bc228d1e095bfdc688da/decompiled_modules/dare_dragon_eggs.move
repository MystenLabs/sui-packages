module 0x34db0e1c931a35abf2cf30d28b4dbf97ea4a98e199a8bc228d1e095bfdc688da::dare_dragon_eggs {
    struct DARE_DRAGON_EGGS has drop {
        dummy_field: bool,
    }

    struct DareDragonEgg has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    fun init(arg0: DARE_DRAGON_EGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DARE_DRAGON_EGGS>(arg0, arg1);
        let v1 = 0x2::display::new<DareDragonEgg>(&v0, arg1);
        0x2::display::add<DareDragonEgg>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<DareDragonEgg>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Dare Dragon Eggs"));
        0x2::display::add<DareDragonEgg>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"999 rare Dare Dragon eggs - Let the Egg Hunt begin!"));
        0x2::display::add<DareDragonEgg>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::add<DareDragonEgg>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://daredragons.com"));
        0x2::display::add<DareDragonEgg>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<DareDragonEgg>(&mut v1);
        let (v2, v3) = 0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop::new(arg1);
        let v4 = v2;
        let v5 = 0x801d62e2937916fca8cdb25e9248fa958c9094c529943528cb602f4f1a114129::warehouse_pseudorandom::new<DareDragonEgg>(arg1);
        let (v6, v7) = 0x2::transfer_policy::new<DareDragonEgg>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x801d62e2937916fca8cdb25e9248fa958c9094c529943528cb602f4f1a114129::warehouse_pseudorandom_rule::add_withdraw<DareDragonEgg>(&mut v9, &v8, &v5);
        0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop_rule::add<DareDragonEgg>(&mut v9, &v8, &v4);
        let v10 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v10, @0xfb7a778200a58bf5f407857562d4f5f3d7034b545d50d52fb2199c24c5cdbf5, 8000);
        0x2::vec_map::insert<address, u16>(&mut v10, @0x20a4ef0deee3a3d5199226fb9b6585727f6a4481a453085ad23ddfbe5393dc46, 2000);
        let v11 = 0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_proportional_rule::new<0xcfd609dedf573a72981504554ec737f6e09ddfeec3ff9927bd135b82566a5d2b::orderbook_kiosk::OrderbookRoyaltyWitness>(0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_share::from_shares(v10), 500, arg1);
        let (v12, v13) = 0x2::transfer_policy::new<DareDragonEgg>(&v0, arg1);
        let v14 = v13;
        let v15 = v12;
        0xcfd609dedf573a72981504554ec737f6e09ddfeec3ff9927bd135b82566a5d2b::orderbook_rule::add<DareDragonEgg>(&mut v15, &v14);
        0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_proportional_rule::add<0xcfd609dedf573a72981504554ec737f6e09ddfeec3ff9927bd135b82566a5d2b::orderbook_kiosk::OrderbookRoyaltyWitness, DareDragonEgg>(&mut v15, &v14, &v11);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<DareDragonEgg>(&mut v15, &v14);
        0x2::transfer::public_transfer<0x2::display::Display<DareDragonEgg>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::MintCap<DareDragonEgg>>(0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::new<DARE_DRAGON_EGGS, DareDragonEgg>(&arg0, 999, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop::AirdropCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<DareDragonEgg>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<DareDragonEgg>>(v14, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop::Airdrop>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DareDragonEgg>>(v9);
        0x2::transfer::public_share_object<0x801d62e2937916fca8cdb25e9248fa958c9094c529943528cb602f4f1a114129::warehouse_pseudorandom::WarehousePseudorandom<DareDragonEgg>>(v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DareDragonEgg>>(v15);
        0x2::transfer::public_share_object<0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_proportional_rule::RoyaltyProportional<0xcfd609dedf573a72981504554ec737f6e09ddfeec3ff9927bd135b82566a5d2b::orderbook_kiosk::OrderbookRoyaltyWitness>>(v11);
    }

    fun mint(arg0: &mut 0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::MintCap<DareDragonEgg>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : DareDragonEgg {
        let v0 = DareDragonEgg{
            id         : 0x2::object::new(arg5),
            name       : arg1,
            image      : arg2,
            attributes : 0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_utils::vec_map_from_vec<0x1::string::String, 0x1::string::String>(arg3, arg4),
        };
        0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::mint<DareDragonEgg>(arg0, 0x2::object::id<DareDragonEgg>(&v0));
        v0
    }

    public entry fun mint_to_warehouse(arg0: &mut 0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_cap::MintCap<DareDragonEgg>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x801d62e2937916fca8cdb25e9248fa958c9094c529943528cb602f4f1a114129::warehouse_pseudorandom::WarehousePseudorandom<DareDragonEgg>, arg6: &mut 0x2::tx_context::TxContext) {
        0x801d62e2937916fca8cdb25e9248fa958c9094c529943528cb602f4f1a114129::warehouse_pseudorandom::deposit<DareDragonEgg>(arg5, mint(arg0, arg1, arg2, arg3, arg4, arg6));
    }

    // decompiled from Move bytecode v6
}

