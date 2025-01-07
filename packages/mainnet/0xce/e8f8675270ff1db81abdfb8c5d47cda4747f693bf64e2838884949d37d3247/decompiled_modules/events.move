module 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::events {
    struct Flip has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        player: address,
        player_won: bool,
        stake: u64,
        fee: u64,
        bet: bool,
        patnership: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct AutoFlip has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        player: address,
        player_won: bool,
        tie: bool,
        fee: u64,
        stake: u64,
        total_bets: u16,
        correct_bets: u16,
        patnership: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    public(friend) fun emit_auto_flip<T0>(arg0: address, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u16, arg6: u16, arg7: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = AutoFlip{
            coin         : 0x1::type_name::get<T0>(),
            player       : arg0,
            player_won   : arg1,
            tie          : arg2,
            fee          : arg3,
            stake        : arg4,
            total_bets   : arg5,
            correct_bets : arg6,
            patnership   : arg7,
        };
        0x2::event::emit<AutoFlip>(v0);
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

    // decompiled from Move bytecode v6
}

