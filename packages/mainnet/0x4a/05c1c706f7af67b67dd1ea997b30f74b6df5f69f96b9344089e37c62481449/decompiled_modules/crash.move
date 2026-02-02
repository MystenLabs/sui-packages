module 0x4a05c1c706f7af67b67dd1ea997b30f74b6df5f69f96b9344089e37c62481449::crash {
    struct CrashResult has copy, drop {
        player: address,
        bet_amount: u64,
        won: bool,
        multiplier: u64,
        payout: u64,
        crash_point: u8,
        cashed_out_at: u8,
    }

    fun calculate_crash_point(arg0: u64) : u8 {
        let v0 = ((arg0 % 1000) as u64);
        if (v0 < 50) {
            0
        } else if (v0 < 145) {
            1
        } else if (v0 < 238) {
            2
        } else if (v0 < 326) {
            3
        } else if (v0 < 410) {
            4
        } else if (v0 < 490) {
            5
        } else if (v0 < 565) {
            6
        } else if (v0 < 637) {
            7
        } else if (v0 < 705) {
            8
        } else if (v0 < 770) {
            9
        } else if (v0 < 832) {
            10
        } else if (v0 < 890) {
            11
        } else if (v0 < 946) {
            12
        } else if (v0 < 980) {
            13
        } else if (v0 < 990) {
            14
        } else if (v0 < 996) {
            15
        } else if (v0 < 999) {
            16
        } else {
            17
        }
    }

    fun calculate_multiplier(arg0: u8) : u64 {
        if (arg0 == 0) {
            100
        } else if (arg0 == 1) {
            115
        } else if (arg0 == 2) {
            132
        } else if (arg0 == 3) {
            152
        } else if (arg0 == 4) {
            175
        } else if (arg0 == 5) {
            201
        } else if (arg0 == 6) {
            231
        } else if (arg0 == 7) {
            266
        } else if (arg0 == 8) {
            306
        } else if (arg0 == 9) {
            352
        } else if (arg0 == 10) {
            405
        } else if (arg0 == 11) {
            466
        } else if (arg0 == 12) {
            536
        } else if (arg0 == 13) {
            616
        } else if (arg0 == 14) {
            708
        } else if (arg0 == 15) {
            815
        } else if (arg0 == 16) {
            937
        } else if (arg0 == 17) {
            1077
        } else {
            1239
        }
    }

    public entry fun play_crash(arg0: &mut 0x4a05c1c706f7af67b67dd1ea997b30f74b6df5f69f96b9344089e37c62481449::house_pool::HousePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = 0x2::object::id<0x4a05c1c706f7af67b67dd1ea997b30f74b6df5f69f96b9344089e37c62481449::house_pool::HousePool>(arg0);
        0x1::vector::append<u8>(&mut arg2, 0x2::object::id_to_bytes(&v2));
        let v3 = 0x2::hash::keccak256(&arg2);
        let v4 = calculate_crash_point((*0x1::vector::borrow<u8>(&v3, 0) as u64));
        let v5 = arg3 <= v4;
        let v6 = if (v5) {
            arg3
        } else {
            v4
        };
        let v7 = calculate_multiplier(v6);
        let v8 = if (v5) {
            v1 * (v7 as u64) / 100
        } else {
            0
        };
        let v9 = 0x4a05c1c706f7af67b67dd1ea997b30f74b6df5f69f96b9344089e37c62481449::house_pool::process_bet(arg0, arg1, v5, v8, b"crash", arg4);
        let v10 = CrashResult{
            player        : v0,
            bet_amount    : v1,
            won           : v5,
            multiplier    : v7,
            payout        : v8,
            crash_point   : v4,
            cashed_out_at : arg3,
        };
        0x2::event::emit<CrashResult>(v10);
        if (0x2::coin::value<0x2::sui::SUI>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v9);
        };
    }

    // decompiled from Move bytecode v6
}

