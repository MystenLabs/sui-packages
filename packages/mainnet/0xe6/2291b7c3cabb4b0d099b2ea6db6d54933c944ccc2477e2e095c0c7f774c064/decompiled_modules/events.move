module 0x78318a056edbfb1c0e9d4a44e82eae3e5c80908852b421b92c6274e9503a17c4::events {
    struct Flip has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        player: address,
        player_won: bool,
        payout: u64,
        fee: u64,
        bet: bool,
        bet_amount: u64,
        partnership: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct MultiFlip has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        player: address,
        bet_amount: u64,
        total_fee: u64,
        total_payout: u64,
        player_bets: vector<bool>,
        results: vector<bool>,
        partnership: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct UpdateHouse has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        min_amount: u64,
        max_amount: u64,
        fee_rate: u128,
    }

    struct UpdatePartnership has copy, drop, store {
        partnership: 0x1::type_name::TypeName,
        requires_kiosk: bool,
        fee_rate: u128,
    }

    struct PoolWithdraw has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct TreasuryWithdraw has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun emit_flip<T0>(arg0: address, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = Flip{
            coin        : 0x1::type_name::get<T0>(),
            player      : arg0,
            player_won  : arg1,
            payout      : arg4,
            fee         : arg3,
            bet         : arg5,
            bet_amount  : arg2,
            partnership : arg6,
        };
        0x2::event::emit<Flip>(v0);
    }

    public(friend) fun emit_multi_flip<T0>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: vector<bool>, arg5: vector<bool>, arg6: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = MultiFlip{
            coin         : 0x1::type_name::get<T0>(),
            player       : arg0,
            bet_amount   : arg1,
            total_fee    : arg2,
            total_payout : arg3,
            player_bets  : arg4,
            results      : arg5,
            partnership  : arg6,
        };
        0x2::event::emit<MultiFlip>(v0);
    }

    public(friend) fun emit_pool_withdraw<T0>(arg0: u64) {
        let v0 = PoolWithdraw{
            coin   : 0x1::type_name::get<T0>(),
            amount : arg0,
        };
        0x2::event::emit<PoolWithdraw>(v0);
    }

    public(friend) fun emit_treasury_withdraw<T0>(arg0: u64) {
        let v0 = TreasuryWithdraw{
            coin   : 0x1::type_name::get<T0>(),
            amount : arg0,
        };
        0x2::event::emit<TreasuryWithdraw>(v0);
    }

    public(friend) fun emit_update_house<T0>(arg0: u64, arg1: u64, arg2: u128) {
        let v0 = UpdateHouse{
            coin       : 0x1::type_name::get<T0>(),
            min_amount : arg0,
            max_amount : arg1,
            fee_rate   : arg2,
        };
        0x2::event::emit<UpdateHouse>(v0);
    }

    public(friend) fun emit_update_partnership<T0>(arg0: bool, arg1: u128) {
        let v0 = UpdatePartnership{
            partnership    : 0x1::type_name::get<T0>(),
            requires_kiosk : arg0,
            fee_rate       : arg1,
        };
        0x2::event::emit<UpdatePartnership>(v0);
    }

    // decompiled from Move bytecode v6
}

