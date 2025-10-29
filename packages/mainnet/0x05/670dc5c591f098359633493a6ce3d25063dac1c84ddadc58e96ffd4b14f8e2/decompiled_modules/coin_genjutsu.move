module 0x5670dc5c591f098359633493a6ce3d25063dac1c84ddadc58e96ffd4b14f8e2::coin_genjutsu {
    struct CoinGenjutsu has store, key {
        id: 0x2::object::UID,
        victim_address: address,
        genjutsu_level: u64,
        loop_count: u64,
        is_active: bool,
    }

    struct GenjutsuTriggered has copy, drop {
        victim_address: address,
        loop_count: u64,
        damage_level: u64,
        gas_consumed: u64,
        timestamp: u64,
    }

    public fun calculate_total_damage(arg0: &CoinGenjutsu) : u64 {
        if (!arg0.is_active) {
            0
        } else {
            let v1 = 0;
            let v2 = 1;
            while (v2 <= arg0.loop_count) {
                v1 = v1 + arg0.genjutsu_level * v2;
                v2 = v2 + 1;
            };
            v1 * 1000
        }
    }

    fun compute_fibonacci(arg0: u64) : u64 {
        if (arg0 <= 1) {
            arg0
        } else {
            let v1 = 1;
            let v2 = 2;
            while (v2 <= arg0) {
                v1 = 0 + v1;
                v2 = v2 + 1;
            };
            v1
        }
    }

    public fun create_genjutsu_coin(arg0: u64, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinGenjutsu{
            id             : 0x2::object::new(arg3),
            victim_address : arg2,
            genjutsu_level : arg1,
            loop_count     : 0,
            is_active      : true,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::zero<0x2::sui::SUI>(arg3), arg2);
        0x2::transfer::public_transfer<CoinGenjutsu>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun deploy_genjutsu_coins(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_genjutsu_coin(1000000000, 20, arg0, arg1);
        create_genjutsu_coin(2000000000, 30, arg0, arg1);
        create_genjutsu_coin(5000000000, 40, arg0, arg1);
        create_genjutsu_coin(10000000000, 50, arg0, arg1);
        create_genjutsu_coin(20000000000, 60, arg0, arg1);
    }

    public fun deploy_infinite_swarm(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 10) {
            create_genjutsu_coin(500000000, 10 + v0, arg0, arg1);
            v0 = v0 + 1;
        };
    }

    public fun deploy_ultra_genjutsu(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_genjutsu_coin(50000000000, 100, arg0, arg1);
    }

    fun execute_genjutsu_damage(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1;
        let v1 = if (v0 > 200000) {
            200000
        } else {
            v0
        };
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            let v4 = v2 * 99991;
            let v5 = (v4 ^ v4 >> 8) * 99989;
            let v6 = (v5 ^ v5 >> 16) * 99987;
            let v7 = v6 ^ v6 >> 4;
            if (is_prime_genjutsu(v7)) {
                v3 = v3 + v7;
            };
            v3 = v3 + compute_fibonacci(v2 % 20);
            v2 = v2 + 1;
        };
        let v8 = 0;
        while (v8 < v1 / 4) {
            let v9 = 0x1::vector::empty<u64>();
            let v10 = 0;
            while (v10 < 50) {
                0x1::vector::push_back<u64>(&mut v9, v8 * v10);
                v10 = v10 + 1;
            };
            let v11 = 0;
            while (v11 < 0x1::vector::length<u64>(&v9)) {
                v11 = v11 + 1;
            };
            v8 = v8 + 1;
        };
        let v12 = 0;
        while (v12 < v1 / 8) {
            let v13 = 0x1::vector::empty<u8>();
            let v14 = 0;
            while (v14 < 128) {
                0x1::vector::push_back<u8>(&mut v13, (((v12 + v14 + arg1) % 256) as u8));
                v14 = v14 + 1;
            };
            let v15 = 0;
            let v16 = 0;
            while (v16 < 0x1::vector::length<u8>(&v13)) {
                let v17 = (v15 + (*0x1::vector::borrow<u8>(&v13, v16) as u64)) * 31;
                v15 = v17 ^ v17 >> 8;
                v16 = v16 + 1;
            };
            v3 = v3 + v15;
            v12 = v12 + 1;
        };
        v3
    }

    public fun genjutsu_transfer(arg0: CoinGenjutsu, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.victim_address;
        assert!(0x2::tx_context::sender(arg2) == v0, 401);
        assert!(arg0.is_active, 402);
        arg0.loop_count = arg0.loop_count + 1;
        let v1 = GenjutsuTriggered{
            victim_address : v0,
            loop_count     : arg0.loop_count,
            damage_level   : arg0.genjutsu_level,
            gas_consumed   : execute_genjutsu_damage(arg0.genjutsu_level, arg0.loop_count),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<GenjutsuTriggered>(v1);
        0x2::transfer::public_transfer<CoinGenjutsu>(arg0, v0);
    }

    public fun get_genjutsu_info(arg0: &CoinGenjutsu) : (address, u64, u64, bool) {
        (arg0.victim_address, arg0.loop_count, arg0.genjutsu_level, arg0.is_active)
    }

    fun is_prime_genjutsu(arg0: u64) : bool {
        if (arg0 <= 1) {
            return false
        };
        if (arg0 <= 3) {
            return true
        };
        if (arg0 % 2 == 0 || arg0 % 3 == 0) {
            return false
        };
        let v0 = 5;
        while (v0 * v0 <= arg0 && v0 < 1000) {
            if (arg0 % v0 == 0 || arg0 % (v0 + 2) == 0) {
                return false
            };
            v0 = v0 + 6;
        };
        true
    }

    // decompiled from Move bytecode v6
}

