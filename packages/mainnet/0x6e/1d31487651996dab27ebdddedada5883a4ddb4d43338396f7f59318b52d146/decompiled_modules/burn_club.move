module 0x6e1d31487651996dab27ebdddedada5883a4ddb4d43338396f7f59318b52d146::burn_club {
    struct GameStarted has copy, drop {
        game_id: u64,
        start_time: u64,
        end_time: u64,
    }

    struct BidPlaced has copy, drop {
        game_id: u64,
        bidder: address,
        amount: u64,
        new_end_time: u64,
    }

    struct GameEnded has copy, drop {
        game_id: u64,
        winner: address,
        pot_amount: u64,
    }

    struct BurnGame has store, key {
        id: 0x2::object::UID,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        highest_bid: u64,
        end_time: u64,
        leader: address,
        fee_recipient: address,
        duration_secs: u64,
        game_counter: u64,
        total_sui: u64,
    }

    struct GameInfo has copy, drop {
        game_id: u64,
        pot_amount: u64,
        highest_bid: u64,
        end_time: u64,
        leader: address,
        active: bool,
        total_sui: u64,
    }

    public entry fun bid(arg0: &mut BurnGame, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 < arg0.end_time, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 % 1000000000 == 0, 4);
        let v2 = arg0.highest_bid / 1000000000;
        assert!(v1 / 1000000000 >= v2 + get_min_increment(v2), 2);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v1 * 1000 / 10000), arg3), arg0.fee_recipient);
        arg0.highest_bid = v1;
        arg0.leader = 0x2::tx_context::sender(arg3);
        arg0.total_sui = arg0.total_sui + v1;
        let v4 = if (arg0.end_time > v0) {
            arg0.end_time - v0
        } else {
            0
        };
        let v5 = v4 + 900;
        let v6 = 86400;
        let v7 = if (v5 > v6) {
            v6
        } else {
            v5
        };
        arg0.end_time = v0 + v7;
        let v8 = BidPlaced{
            game_id      : arg0.game_counter,
            bidder       : 0x2::tx_context::sender(arg3),
            amount       : v1,
            new_end_time : arg0.end_time,
        };
        0x2::event::emit<BidPlaced>(v8);
    }

    public fun get_game_info(arg0: &BurnGame, arg1: &0x2::clock::Clock) : GameInfo {
        GameInfo{
            game_id     : arg0.game_counter,
            pot_amount  : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
            highest_bid : arg0.highest_bid,
            end_time    : arg0.end_time,
            leader      : arg0.leader,
            active      : arg0.end_time > 0x2::clock::timestamp_ms(arg1) / 1000,
            total_sui   : arg0.total_sui,
        }
    }

    public fun get_min_increment(arg0: u64) : u64 {
        let v0 = (arg0 * 10 + 99) / 100;
        if (v0 > 1) {
            v0
        } else {
            1
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnGame{
            id            : 0x2::object::new(arg0),
            pot           : 0x2::balance::zero<0x2::sui::SUI>(),
            highest_bid   : 0,
            end_time      : 0,
            leader        : @0x0,
            fee_recipient : @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad,
            duration_secs : 86400,
            game_counter  : 0,
            total_sui     : 0,
        };
        0x2::transfer::share_object<BurnGame>(v0);
    }

    public entry fun start_new_game(arg0: &mut BurnGame, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 >= arg0.end_time, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 5000000000, 2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot), arg3), arg0.leader);
        };
        let v2 = GameEnded{
            game_id    : arg0.game_counter,
            winner     : arg0.leader,
            pot_amount : v1,
        };
        0x2::event::emit<GameEnded>(v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.game_counter = arg0.game_counter + 1;
        arg0.highest_bid = 1000000000;
        arg0.end_time = v0 + arg0.duration_secs;
        arg0.leader = 0x2::tx_context::sender(arg3);
        arg0.total_sui = 5000000000;
        let v3 = GameStarted{
            game_id    : arg0.game_counter,
            start_time : v0,
            end_time   : arg0.end_time,
        };
        0x2::event::emit<GameStarted>(v3);
        let v4 = BidPlaced{
            game_id      : arg0.game_counter,
            bidder       : 0x2::tx_context::sender(arg3),
            amount       : 1000000000,
            new_end_time : arg0.end_time,
        };
        0x2::event::emit<BidPlaced>(v4);
    }

    // decompiled from Move bytecode v6
}

