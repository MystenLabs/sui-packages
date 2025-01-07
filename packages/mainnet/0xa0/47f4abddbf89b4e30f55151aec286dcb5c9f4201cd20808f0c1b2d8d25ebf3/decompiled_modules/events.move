module 0xa047f4abddbf89b4e30f55151aec286dcb5c9f4201cd20808f0c1b2d8d25ebf3::events {
    struct Flip has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        player: address,
        player_won: bool,
        payout: u64,
        fee: u64,
        bet: bool,
        bet_amount: u64,
        patnership: 0x1::option::Option<0x1::type_name::TypeName>,
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

    public(friend) fun emit_flip<T0>(arg0: address, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = Flip{
            coin       : 0x1::type_name::get<T0>(),
            player     : arg0,
            player_won : arg1,
            payout     : arg4,
            fee        : arg3,
            bet        : arg5,
            bet_amount : arg2,
            patnership : arg6,
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

    // decompiled from Move bytecode v6
}

