module 0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::scratch {
    struct ScratchResult has copy, drop {
        player: address,
        bet_amount: u64,
        won: bool,
        card_type: u8,
        multiplier: u64,
        payout: u64,
        symbols: vector<u8>,
    }

    fun determine_scratch_outcome(arg0: &vector<u8>, arg1: u8) : (bool, u64) {
        if (arg1 == 0) {
            if (!(*0x1::vector::borrow<u8>(arg0, 0) < 77)) {
                return (false, 0)
            };
            let v2 = *0x1::vector::borrow<u8>(arg0, 1);
            if (v2 > 240) {
                (true, 5000)
            } else if (v2 > 200) {
                (true, 1000)
            } else if (v2 > 150) {
                (true, 500)
            } else {
                (true, 200)
            }
        } else if (arg1 == 1) {
            if (!(*0x1::vector::borrow<u8>(arg0, 0) < 64)) {
                return (false, 0)
            };
            let v3 = *0x1::vector::borrow<u8>(arg0, 1);
            if (v3 > 250) {
                (true, 10000)
            } else {
                let (v4, v5) = if (v3 > 230) {
                    (2500, true)
                } else {
                    let (v6, v7) = if (v3 > 180) {
                        (true, 1000)
                    } else {
                        (true, 500)
                    };
                    (v7, v6)
                };
                (v5, v4)
            }
        } else if (arg1 == 2) {
            if (!(*0x1::vector::borrow<u8>(arg0, 0) < 51)) {
                return (false, 0)
            };
            let v8 = *0x1::vector::borrow<u8>(arg0, 1);
            if (v8 > 254) {
                (true, 50000)
            } else if (v8 > 245) {
                (true, 10000)
            } else if (v8 > 220) {
                (true, 5000)
            } else {
                (true, 1000)
            }
        } else {
            if (!(*0x1::vector::borrow<u8>(arg0, 0) < 38)) {
                return (false, 0)
            };
            let v9 = *0x1::vector::borrow<u8>(arg0, 1);
            if (v9 > 255) {
                (true, 500000)
            } else if (v9 > 252) {
                (true, 100000)
            } else if (v9 > 240) {
                (true, 10000)
            } else {
                (true, 500)
            }
        }
    }

    fun ensure_no_winning_line(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = vector[vector[0, 1, 2], vector[3, 4, 5], vector[6, 7, 8], vector[0, 3, 6], vector[1, 4, 7], vector[2, 5, 8], vector[0, 4, 8], vector[2, 4, 6]];
        let v1 = 0;
        while (v1 < 8) {
            let v2 = 0x1::vector::borrow<vector<u64>>(&v0, v1);
            let v3 = *0x1::vector::borrow<u64>(v2, 2);
            let v4 = *0x1::vector::borrow<u8>(arg0, *0x1::vector::borrow<u64>(v2, 0));
            if (v4 == *0x1::vector::borrow<u8>(arg0, *0x1::vector::borrow<u64>(v2, 1)) && v4 == *0x1::vector::borrow<u8>(arg0, v3)) {
                let v5 = *0x1::vector::borrow<u8>(arg1, (v1 + 12) % 32) % 7;
                if (v5 == v4) {
                    *0x1::vector::borrow_mut<u8>(arg0, v3) = (v5 + 1) % 8;
                } else {
                    *0x1::vector::borrow_mut<u8>(arg0, v3) = v5;
                };
            };
            v1 = v1 + 1;
        };
    }

    fun generate_scratch_grid(arg0: &vector<u8>, arg1: bool, arg2: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        if (arg1) {
            let v2 = *0x1::vector::borrow<u8>(arg0, 2) % 8;
            let v3 = *0x1::vector::borrow<u8>(arg0, 3) % 8;
            while (v1 < 9) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, (v1 + 4) % 32) % 8);
                v1 = v1 + 1;
            };
            if (v3 == 0) {
                *0x1::vector::borrow_mut<u8>(&mut v0, 0) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 1) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 2) = v2;
            } else if (v3 == 1) {
                *0x1::vector::borrow_mut<u8>(&mut v0, 3) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 4) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 5) = v2;
            } else if (v3 == 2) {
                *0x1::vector::borrow_mut<u8>(&mut v0, 6) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 7) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 8) = v2;
            } else if (v3 == 3) {
                *0x1::vector::borrow_mut<u8>(&mut v0, 0) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 3) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 6) = v2;
            } else if (v3 == 4) {
                *0x1::vector::borrow_mut<u8>(&mut v0, 1) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 4) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 7) = v2;
            } else if (v3 == 5) {
                *0x1::vector::borrow_mut<u8>(&mut v0, 2) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 5) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 8) = v2;
            } else if (v3 == 6) {
                *0x1::vector::borrow_mut<u8>(&mut v0, 0) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 4) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 8) = v2;
            } else {
                *0x1::vector::borrow_mut<u8>(&mut v0, 2) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 4) = v2;
                *0x1::vector::borrow_mut<u8>(&mut v0, 6) = v2;
            };
        } else {
            while (v1 < 9) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, (v1 + 4) % 32) % 8);
                v1 = v1 + 1;
            };
            let v4 = &mut v0;
            ensure_no_winning_line(v4, arg0);
        };
        v0
    }

    public entry fun play_scratch(arg0: &mut 0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::house_pool::HousePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg3 < 4, 0);
        let v2 = 0x2::object::id<0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::house_pool::HousePool>(arg0);
        0x1::vector::append<u8>(&mut arg2, 0x2::object::id_to_bytes(&v2));
        let v3 = 0x2::hash::keccak256(&arg2);
        let (v4, v5) = determine_scratch_outcome(&v3, arg3);
        let v6 = if (v4) {
            v1 * (v5 as u64) / 100
        } else {
            0
        };
        let v7 = 0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::house_pool::process_bet(arg0, arg1, v4, v6, b"scratch", arg4);
        let v8 = ScratchResult{
            player     : v0,
            bet_amount : v1,
            won        : v4,
            card_type  : arg3,
            multiplier : v5,
            payout     : v6,
            symbols    : generate_scratch_grid(&v3, v4, arg3),
        };
        0x2::event::emit<ScratchResult>(v8);
        if (0x2::coin::value<0x2::sui::SUI>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        };
    }

    // decompiled from Move bytecode v6
}

