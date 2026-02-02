module 0x346c31a4c87f2b1a6a86400efbe81832fa82857996d15c2d58dafca306288c26::race {
    struct RaceResult has copy, drop {
        player: address,
        bet_amount: u64,
        won: bool,
        selected_car: u8,
        winner_car: u8,
        multiplier: u64,
        payout: u64,
    }

    fun determine_winner(arg0: &vector<u8>, arg1: &vector<u64>) : u8 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 6) {
            let v3 = 100000 / *0x1::vector::borrow<u64>(arg1, v2);
            0x1::vector::push_back<u64>(&mut v0, v3);
            v1 = v1 + v3;
            v2 = v2 + 1;
        };
        let v4 = 0;
        v2 = 0;
        while (v2 < 6) {
            v4 = v4 + *0x1::vector::borrow<u64>(&v0, v2);
            if (((*0x1::vector::borrow<u8>(arg0, 16) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, 17) as u64)) % v1 < v4) {
                return (v2 as u8)
            };
            v2 = v2 + 1;
        };
        5
    }

    fun generate_race_odds(arg0: &vector<u8>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 6) {
            0x1::vector::push_back<u64>(&mut v1, 50 + (*0x1::vector::borrow<u8>(arg0, v2 % 32) as u64) % 100);
            v2 = v2 + 1;
        };
        let v3 = *0x1::vector::borrow<u8>(arg0, 6);
        if (v3 < 77) {
            let v4 = (v3 as u64) % 6;
            *0x1::vector::borrow_mut<u64>(&mut v1, v4) = *0x1::vector::borrow<u64>(&v1, v4) + 80;
        };
        let v5 = 0;
        v2 = 0;
        while (v2 < 6) {
            v5 = v5 + *0x1::vector::borrow<u64>(&v1, v2);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 6) {
            let v6 = 940000 / *0x1::vector::borrow<u64>(&v1, v2) * 10000 / v5;
            let v7 = if (v6 < 110) {
                110
            } else {
                v6
            };
            0x1::vector::push_back<u64>(&mut v0, v7);
            v2 = v2 + 1;
        };
        v0
    }

    public entry fun play_race(arg0: &mut 0x346c31a4c87f2b1a6a86400efbe81832fa82857996d15c2d58dafca306288c26::house_pool::HousePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg3 < 6, 0);
        let v2 = 0x2::object::id<0x346c31a4c87f2b1a6a86400efbe81832fa82857996d15c2d58dafca306288c26::house_pool::HousePool>(arg0);
        0x1::vector::append<u8>(&mut arg2, 0x2::object::id_to_bytes(&v2));
        let v3 = 0x2::hash::keccak256(&arg2);
        let v4 = generate_race_odds(&v3);
        let v5 = determine_winner(&v3, &v4);
        let v6 = arg3 == v5;
        let v7 = *0x1::vector::borrow<u64>(&v4, (arg3 as u64));
        let v8 = if (v6) {
            v1 * (v7 as u64) / 100
        } else {
            0
        };
        let v9 = 0x346c31a4c87f2b1a6a86400efbe81832fa82857996d15c2d58dafca306288c26::house_pool::process_bet(arg0, arg1, v6, v8, b"race", arg4);
        let v10 = RaceResult{
            player       : v0,
            bet_amount   : v1,
            won          : v6,
            selected_car : arg3,
            winner_car   : v5,
            multiplier   : v7,
            payout       : v8,
        };
        0x2::event::emit<RaceResult>(v10);
        if (0x2::coin::value<0x2::sui::SUI>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v9);
        };
    }

    // decompiled from Move bytecode v6
}

