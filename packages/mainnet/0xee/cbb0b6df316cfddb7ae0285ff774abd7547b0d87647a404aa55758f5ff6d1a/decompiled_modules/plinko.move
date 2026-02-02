module 0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::plinko {
    struct PlinkoResult has copy, drop {
        player: address,
        bet_amount: u64,
        final_position: u64,
        multiplier: u64,
        payout: u64,
        won: bool,
        risk: u8,
        rows: u8,
        timestamp: u64,
    }

    fun calculate_final_position(arg0: vector<u8>, arg1: vector<u8>, arg2: u8) : u64 {
        0x1::vector::append<u8>(&mut arg0, arg1);
        let v0 = 0x2::hash::keccak256(&arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 16) {
            let v3 = v1 << 8;
            v1 = v3 | (*0x1::vector::borrow<u8>(&v0, v2) as u128);
            v2 = v2 + 1;
        };
        let v4 = 0;
        let v5 = 0;
        let v6 = v1;
        while (v5 < arg2) {
            if (v6 & 1 == 1) {
                v4 = v4 + 1;
            };
            v6 = v6 >> 1;
            v5 = v5 + 1;
        };
        v4
    }

    fun generate_server_seed(arg0: &0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x2::tx_context::epoch(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v2));
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v3));
        0x2::hash::keccak256(&v0)
    }

    fun get_multiplier(arg0: u8, arg1: u8, arg2: u64) : u64 {
        let v0 = if (arg1 == 8) {
            if (arg0 == 0) {
                vector[560, 210, 110, 100, 50, 100, 110, 210, 560]
            } else if (arg0 == 1) {
                vector[1300, 300, 130, 70, 40, 70, 130, 300, 1300]
            } else {
                vector[2900, 400, 150, 30, 20, 30, 150, 400, 2900]
            }
        } else if (arg1 == 12) {
            if (arg0 == 0) {
                vector[1000, 300, 160, 140, 110, 100, 50, 100, 110, 140, 160, 300, 1000]
            } else if (arg0 == 1) {
                vector[3300, 1100, 400, 200, 110, 60, 30, 60, 110, 200, 400, 1100, 3300]
            } else {
                vector[17000, 2400, 810, 200, 70, 20, 10, 20, 70, 200, 810, 2400, 17000]
            }
        } else if (arg0 == 0) {
            vector[1600, 900, 200, 140, 140, 120, 110, 100, 50, 100, 110, 120, 140, 140, 200, 900, 1600]
        } else if (arg0 == 1) {
            vector[11000, 4100, 1000, 500, 300, 150, 100, 50, 30, 50, 100, 150, 300, 500, 1000, 4100, 11000]
        } else {
            vector[100000, 13000, 2600, 900, 400, 200, 20, 20, 10, 20, 20, 200, 400, 900, 2600, 13000, 100000]
        };
        let v1 = v0;
        let v2 = 0x1::vector::length<u64>(&v1);
        let v3 = if (arg2 >= v2) {
            v2 - 1
        } else {
            arg2
        };
        *0x1::vector::borrow<u64>(&v1, v3)
    }

    public entry fun play_plinko(arg0: &mut 0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::house_pool::HousePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 2, 0);
        let v0 = if (arg4 == 8) {
            true
        } else if (arg4 == 12) {
            true
        } else {
            arg4 == 16
        };
        assert!(v0, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 2);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = calculate_final_position(generate_server_seed(arg5), arg2, arg4);
        let v4 = get_multiplier(arg3, arg4, v3);
        let v5 = v1 * v4 / 100;
        let v6 = v5 > v1;
        let v7 = 0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::house_pool::process_bet(arg0, arg1, v6, v5, b"plinko", arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        };
        let v8 = PlinkoResult{
            player         : v2,
            bet_amount     : v1,
            final_position : v3,
            multiplier     : v4,
            payout         : v5,
            won            : v6,
            risk           : arg3,
            rows           : arg4,
            timestamp      : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<PlinkoResult>(v8);
    }

    // decompiled from Move bytecode v6
}

