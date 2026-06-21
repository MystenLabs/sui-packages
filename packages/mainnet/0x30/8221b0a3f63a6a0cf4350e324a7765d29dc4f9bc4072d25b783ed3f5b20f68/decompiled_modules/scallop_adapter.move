module 0x308221b0a3f63a6a0cf4350e324a7765d29dc4f9bc4072d25b783ed3f5b20f68::scallop_adapter {
    struct SCALLOP has drop {
        dummy_field: bool,
    }

    struct ScallopPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        scoin: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    public fun owner_redeem<T0>(arg0: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T0>, arg1: &0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::OwnerCap<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let ScallopPosition {
            id    : v0,
            scoin : v1,
        } = 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::owner_take_receipt<T0, ScallopPosition<T0>>(arg0, arg1, 1);
        0x2::object::delete(v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v1, arg5), arg4, arg5)
    }

    public fun verified_supply_scallop_entry<T0>(arg0: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision::DecisionRegistry, arg1: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T0>, arg2: &0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::Enclave<0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision::DECISION>, arg3: &0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::AgentCap<T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: u16, arg7: vector<u8>, arg8: address, arg9: address, arg10: u64, arg11: u64, arg12: u8, arg13: u8, arg14: vector<u8>, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u8>, arg19: vector<u8>, arg20: vector<u8>, arg21: u64, arg22: vector<u8>, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        let v0 = SCALLOP{dummy_field: false};
        let (v1, v2) = 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision::verified_release<T0, SCALLOP>(v0, arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        let v3 = v2;
        if (0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::ticket_has_position<T0>(arg1, &v3)) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::borrow_for_ticket<T0, ScallopPosition<T0>>(arg1, &v3).scoin, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg4, arg5, v1, arg23, arg24)));
            0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::discharge_existing<T0>(arg1, v3);
        } else {
            let v4 = ScallopPosition<T0>{
                id    : 0x2::object::new(arg24),
                scoin : 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg4, arg5, v1, arg23, arg24)),
            };
            0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::custody_new<T0, ScallopPosition<T0>>(arg1, v3, v4);
        };
    }

    // decompiled from Move bytecode v7
}

