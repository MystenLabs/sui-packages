module 0x4a05c1c706f7af67b67dd1ea997b30f74b6df5f69f96b9344089e37c62481449::mines {
    struct MinesResult has copy, drop {
        player: address,
        bet_amount: u64,
        won: bool,
        mines_count: u8,
        tiles_revealed: vector<u8>,
        hit_mine_at: u8,
        final_multiplier: u64,
        payout: u64,
    }

    fun generate_mine_positions(arg0: &vector<u8>, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 25) {
            0x1::vector::push_back<u8>(&mut v1, v2);
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < arg1 && 0x1::vector::length<u8>(&v1) > 0) {
            0x1::vector::push_back<u8>(&mut v0, 0x1::vector::remove<u8>(&mut v1, (*0x1::vector::borrow<u8>(arg0, (v3 as u64) % 0x1::vector::length<u8>(arg0)) as u64) % 0x1::vector::length<u8>(&v1)));
            v3 = v3 + 1;
        };
        v0
    }

    fun is_mine(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun play_mines(arg0: &mut 0x4a05c1c706f7af67b67dd1ea997b30f74b6df5f69f96b9344089e37c62481449::house_pool::HousePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = 0x2::object::id<0x4a05c1c706f7af67b67dd1ea997b30f74b6df5f69f96b9344089e37c62481449::house_pool::HousePool>(arg0);
        0x1::vector::append<u8>(&mut arg2, 0x2::object::id_to_bytes(&v2));
        let v3 = 0x2::hash::keccak256(&arg2);
        let v4 = generate_mine_positions(&v3, arg3);
        let v5 = 100;
        let v6 = 0;
        let v7 = 255;
        let v8 = 25;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u8>(&arg4)) {
            if (is_mine(&v4, *0x1::vector::borrow<u8>(&arg4, v9))) {
                v7 = v6;
                break
            };
            let v10 = v6 + 1;
            v6 = v10;
            let v11 = ((v8 - arg3 - v10) as u64);
            if (v11 > 0) {
                let v12 = v5 * ((v8 - v10) as u64) * (100 + 50 * ((arg3 - 1) as u64));
                v5 = v12 / v11 * 100;
            };
            v9 = v9 + 1;
        };
        let v13 = v7 == 255 && v6 > 0;
        let v14 = if (v13) {
            v1 * v5 / 100
        } else {
            0
        };
        let v15 = 0x4a05c1c706f7af67b67dd1ea997b30f74b6df5f69f96b9344089e37c62481449::house_pool::process_bet(arg0, arg1, v13, v14, b"mines", arg5);
        let v16 = MinesResult{
            player           : v0,
            bet_amount       : v1,
            won              : v13,
            mines_count      : arg3,
            tiles_revealed   : arg4,
            hit_mine_at      : v7,
            final_multiplier : v5,
            payout           : v14,
        };
        0x2::event::emit<MinesResult>(v16);
        if (0x2::coin::value<0x2::sui::SUI>(&v15) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v15, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v15);
        };
    }

    // decompiled from Move bytecode v6
}

