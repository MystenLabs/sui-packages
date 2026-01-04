module 0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::cetus_integration {
    struct LiquidityMigrated has copy, drop {
        agent_token_type: address,
        sui_amount: u64,
        token_amount: u64,
        pool_id: address,
        timestamp: u64,
    }

    struct DevFeeCollected has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    public fun collect_dev_fee(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5);
    }

    public fun get_aida_address() : address {
        @0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892
    }

    public fun get_dev_wallet() : address {
        @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5
    }

    public fun migrate_to_cetus<T0>(arg0: &mut 0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::BondingCurve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert!(0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::is_bonding_complete<T0>(arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let (v1, v2) = 0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::complete_bonding<T0>(arg0, @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5, arg3);
        let v3 = v2;
        let v4 = v1;
        let v5 = DevFeeCollected{
            amount    : 0x2::coin::value<0x2::sui::SUI>(&v4),
            recipient : @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5,
            timestamp : v0,
        };
        0x2::event::emit<DevFeeCollected>(v5);
        let v6 = LiquidityMigrated{
            agent_token_type : 0x2::object::id_address<0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::BondingCurve<T0>>(arg0),
            sui_amount       : 0x2::coin::value<0x2::sui::SUI>(&v3),
            token_amount     : 0x2::coin::value<T0>(&arg1),
            pool_id          : @0x0,
            timestamp        : v0,
        };
        0x2::event::emit<LiquidityMigrated>(v6);
        (v4, v3, arg1)
    }

    // decompiled from Move bytecode v6
}

