module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::bazaar {
    struct BazaarConfig has key {
        id: 0x2::object::UID,
        version: u64,
        set_id: 0x1::string::String,
        prices: vector<u64>,
        paused: bool,
    }

    struct BazaarBought has copy, drop {
        buyer: address,
        set_id: 0x1::string::String,
        card_id: 0x1::string::String,
        serial: u64,
        paid: u64,
    }

    public fun buy(arg0: &BazaarConfig, arg1: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::SetCatalog, arg2: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::SetSupply, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: 0x2::coin::Coin<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PEARL>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 1);
        assert!(0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::is_frozen(arg1), 6);
        assert!(arg0.set_id == *0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::set_id(arg1), 2);
        let (v0, v1, v2) = 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::find(arg1, &arg5);
        let v3 = v2;
        assert!(v0, 3);
        let v4 = *0x1::vector::borrow<u64>(&arg0.prices, v1);
        assert!(0x2::coin::value<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PEARL>(&arg4) == v4, 4);
        0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::burn(arg3, arg4);
        let v5 = 0x2::tx_context::sender(arg6);
        let v6 = BazaarBought{
            buyer   : v5,
            set_id  : arg0.set_id,
            card_id : arg5,
            serial  : 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::mint_from_pack(arg2, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::meta_card_id(&v3), 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::meta_name(&v3), 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::rarity_label(v1), 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::meta_image(&v3), v5, arg6),
            paid    : v4,
        };
        0x2::event::emit<BazaarBought>(v6);
    }

    public fun buy_soulbound(arg0: &BazaarConfig, arg1: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::SetCatalog, arg2: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::SetSupply, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 1);
        assert!(0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::is_frozen(arg1), 6);
        assert!(arg0.set_id == *0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::set_id(arg1), 2);
        let (v0, v1, v2) = 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::find(arg1, &arg4);
        let v3 = v2;
        assert!(v0, 3);
        let v4 = *0x1::vector::borrow<u64>(&arg0.prices, v1);
        0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::spend_soulbound(arg3, v4, arg5);
        let v5 = 0x2::tx_context::sender(arg5);
        let v6 = BazaarBought{
            buyer   : v5,
            set_id  : arg0.set_id,
            card_id : arg4,
            serial  : 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply::mint_from_pack(arg2, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::meta_card_id(&v3), 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::meta_name(&v3), 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::rarity_label(v1), 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::meta_image(&v3), v5, arg5),
            paid    : v4,
        };
        0x2::event::emit<BazaarBought>(v6);
    }

    public fun migrate(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut BazaarConfig) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun new_bazaar(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                if (arg4 > 0) {
                    if (arg5 > 0) {
                        arg6 > 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, arg3);
        0x1::vector::push_back<u64>(v2, arg4);
        0x1::vector::push_back<u64>(v2, arg5);
        0x1::vector::push_back<u64>(v2, arg6);
        let v3 = BazaarConfig{
            id      : 0x2::object::new(arg7),
            version : 1,
            set_id  : arg1,
            prices  : v1,
            paused  : false,
        };
        0x2::transfer::share_object<BazaarConfig>(v3);
    }

    public fun price_of(arg0: &BazaarConfig, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.prices, arg1)
    }

    public fun set_paused(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut BazaarConfig, arg2: bool) {
        assert!(arg1.version == 1, 0);
        arg1.paused = arg2;
    }

    public fun set_prices(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut BazaarConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg1.version == 1, 0);
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                if (arg4 > 0) {
                    if (arg5 > 0) {
                        arg6 > 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, arg3);
        0x1::vector::push_back<u64>(v2, arg4);
        0x1::vector::push_back<u64>(v2, arg5);
        0x1::vector::push_back<u64>(v2, arg6);
        arg1.prices = v1;
    }

    // decompiled from Move bytecode v7
}

