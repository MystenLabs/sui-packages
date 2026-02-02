module 0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::wheel {
    struct WheelResult has copy, drop {
        player: address,
        bet_amount: u64,
        won: bool,
        target_number: u8,
        result_number: u8,
        risk: u8,
        multiplier: u64,
        payout: u64,
    }

    public entry fun play_wheel(arg0: &mut 0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::house_pool::HousePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg3 >= 1 && arg3 <= 10, 0);
        assert!(arg4 <= 2, 1);
        let v2 = 0x2::object::id<0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::house_pool::HousePool>(arg0);
        0x1::vector::append<u8>(&mut arg2, 0x2::object::id_to_bytes(&v2));
        let v3 = 0x2::hash::keccak256(&arg2);
        let v4 = (((*0x1::vector::borrow<u8>(&v3, 0) as u64) % 10 + 1) as u8);
        let v5 = v4 == arg3;
        let v6 = if (arg4 == 0) {
            150
        } else if (arg4 == 1) {
            300
        } else {
            1000
        };
        let v7 = if (v5) {
            v1 * (v6 as u64) / 100
        } else {
            0
        };
        let v8 = 0xeecbb0b6df316cfddb7ae0285ff774abd7547b0d87647a404aa55758f5ff6d1a::house_pool::process_bet(arg0, arg1, v5, v7, b"wheel", arg5);
        let v9 = WheelResult{
            player        : v0,
            bet_amount    : v1,
            won           : v5,
            target_number : arg3,
            result_number : v4,
            risk          : arg4,
            multiplier    : v6,
            payout        : v7,
        };
        0x2::event::emit<WheelResult>(v9);
        if (0x2::coin::value<0x2::sui::SUI>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
        };
    }

    // decompiled from Move bytecode v6
}

