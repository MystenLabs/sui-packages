module 0xe414ae0af2863923e26355566d5aa5c56b4337d09bc6abd7db38e26a47476cac::real_coin_genjutsu {
    struct GenjutsuKey has store, key {
        id: 0x2::object::UID,
        victim_address: address,
        loop_counter: u64,
        damage_level: u64,
        is_active: bool,
    }

    struct GenjutsuLoop has copy, drop {
        loop_count: u64,
        damage_inflicted: u64,
        bot_address: address,
        timestamp: u64,
    }

    public fun calculate_total_damage(arg0: &GenjutsuKey) : u64 {
        if (!arg0.is_active) {
            0
        } else {
            let v1 = 0;
            let v2 = 1;
            while (v2 <= arg0.loop_counter) {
                v1 = v1 + arg0.damage_level * v2;
                v2 = v2 + 1;
            };
            v1 * 50
        }
    }

    public fun create_real_genjutsu_coin(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GenjutsuKey{
            id             : 0x2::object::new(arg2),
            victim_address : arg1,
            loop_counter   : 0,
            damage_level   : 100000,
            is_active      : true,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::zero<0x2::sui::SUI>(arg2), arg1);
        0x2::transfer::public_transfer<GenjutsuKey>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun deploy_real_genjutsu_coins(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_real_genjutsu_coin(1000000000, arg0, arg1);
        create_real_genjutsu_coin(2000000000, arg0, arg1);
        create_real_genjutsu_coin(5000000000, arg0, arg1);
        create_real_genjutsu_coin(10000000000, arg0, arg1);
        create_real_genjutsu_coin(20000000000, arg0, arg1);
    }

    public fun deploy_ultra_genjutsu(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_real_genjutsu_coin(100000000000, arg0, arg1);
    }

    fun execute_genjutsu_damage(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1;
        let v1 = if (v0 > 500000) {
            500000
        } else {
            v0
        };
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            let v4 = v2 * 99991;
            let v5 = (v4 ^ v4 >> 8) * 99989;
            let v6 = v5 ^ v5 >> 16;
            let v7 = true;
            if (v6 > 2) {
                let v8 = 2;
                while (v8 * v8 <= v6 && v8 < 500) {
                    if (v6 % v8 == 0) {
                        v7 = false;
                        break
                    };
                    v8 = v8 + 1;
                };
            };
            if (v7) {
                while (v6 > 0) {
                    v6 = v6 / 2;
                };
            };
            v3 = v3 + v6;
            v2 = v2 + 1;
        };
        let v9 = 0;
        while (v9 < v1 / 3) {
            let v10 = 0x1::vector::empty<u64>();
            let v11 = 0;
            while (v11 < 100) {
                0x1::vector::push_back<u64>(&mut v10, v9 * v11 * arg1);
                v11 = v11 + 1;
            };
            let v12 = 0;
            while (v12 < 0x1::vector::length<u64>(&v10)) {
                v12 = v12 + 1;
            };
            v9 = v9 + 1;
        };
        v3
    }

    public fun get_genjutsu_info(arg0: &GenjutsuKey) : (address, u64, u64, bool) {
        (arg0.victim_address, arg0.loop_counter, arg0.damage_level, arg0.is_active)
    }

    fun is_bot_transfer(arg0: address, arg1: address) : bool {
        is_suspicious_address(arg1) || is_drain_address(arg1)
    }

    fun is_drain_address(arg0: address) : bool {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 32 && *0x1::vector::borrow<u8>(&v0, v2) == 0) {
            v1 = v1 + 1;
            v2 = v2 + 1;
        };
        let v3 = 0;
        v2 = 1;
        while (v2 < 32) {
            let v4 = *0x1::vector::borrow<u8>(&v0, v2 - 1);
            let v5 = *0x1::vector::borrow<u8>(&v0, v2);
            if (v5 == v4 + 1 || v5 == v4 - 1) {
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        v1 > 5 || v3 > 10
    }

    fun is_suspicious_address(arg0: address) : bool {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 32) {
            if (*0x1::vector::borrow<u8>(&v0, v3) == 0) {
                v1 = v1 + 1;
            };
            if (v3 > 0) {
                if (*0x1::vector::borrow<u8>(&v0, v3) == *0x1::vector::borrow<u8>(&v0, v3 - 1) + 1) {
                    v2 = v2 + 1;
                };
            };
            v3 = v3 + 1;
        };
        v1 > 8 || v2 > 5
    }

    public fun reset_genjutsu(arg0: GenjutsuKey, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.loop_counter = 0;
        arg0.is_active = true;
        0x2::transfer::public_transfer<GenjutsuKey>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_with_genjutsu(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut GenjutsuKey, arg3: &mut 0x2::tx_context::TxContext) {
        if (is_bot_transfer(0x2::tx_context::sender(arg3), arg1)) {
            arg2.loop_counter = arg2.loop_counter + 1;
            let v0 = GenjutsuLoop{
                loop_count       : arg2.loop_counter,
                damage_inflicted : execute_genjutsu_damage(arg2.damage_level, arg2.loop_counter),
                bot_address      : arg1,
                timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
            };
            0x2::event::emit<GenjutsuLoop>(v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

