module 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::events {
    struct Flip has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        player: address,
        player_won: bool,
        payout: u64,
        fee: u64,
        bet: bool,
        patnership: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct MultiFlip has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        player: address,
        total_fee: u64,
        total_payout: u64,
        player_bets: vector<bool>,
        results: vector<bool>,
        partnership: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    public(friend) fun emit_flip<T0>(arg0: address, arg1: bool, arg2: u64, arg3: u64, arg4: bool, arg5: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = Flip{
            coin       : 0x1::type_name::get<T0>(),
            player     : arg0,
            player_won : arg1,
            payout     : arg3,
            fee        : arg2,
            bet        : arg4,
            patnership : arg5,
        };
        0x2::event::emit<Flip>(v0);
    }

    public(friend) fun emit_multi_flip<T0>(arg0: address, arg1: u64, arg2: u64, arg3: vector<bool>, arg4: vector<bool>, arg5: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = MultiFlip{
            coin         : 0x1::type_name::get<T0>(),
            player       : arg0,
            total_fee    : arg1,
            total_payout : arg2,
            player_bets  : arg3,
            results      : arg4,
            partnership  : arg5,
        };
        0x2::event::emit<MultiFlip>(v0);
    }

    // decompiled from Move bytecode v6
}

