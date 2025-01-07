module 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::events {
    struct Flip has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        player: address,
        player_won: bool,
        stake: u64,
        fee: u64,
        bet: bool,
        patnership: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct MultiFlip has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        player: address,
        player_won: bool,
        tie: bool,
        fee: u64,
        stake: u64,
        player_bets: vector<bool>,
        results: vector<bool>,
        partnership: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    public(friend) fun emit_flip<T0>(arg0: address, arg1: bool, arg2: u64, arg3: u64, arg4: bool, arg5: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = Flip{
            coin       : 0x1::type_name::get<T0>(),
            player     : arg0,
            player_won : arg1,
            stake      : arg3,
            fee        : arg2,
            bet        : arg4,
            patnership : arg5,
        };
        0x2::event::emit<Flip>(v0);
    }

    public(friend) fun emit_multi_flip<T0>(arg0: address, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: vector<bool>, arg6: vector<bool>, arg7: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = MultiFlip{
            coin        : 0x1::type_name::get<T0>(),
            player      : arg0,
            player_won  : arg1,
            tie         : arg2,
            fee         : arg3,
            stake       : arg4,
            player_bets : arg5,
            results     : arg6,
            partnership : arg7,
        };
        0x2::event::emit<MultiFlip>(v0);
    }

    // decompiled from Move bytecode v6
}

