module 0x868722d95e01a637c23fa71a9e053c38e8ae66375dbdc051cea7f70659c58ecb::infinite_genjutsu {
    struct GenjutsuTrap has store, key {
        id: 0x2::object::UID,
        victim_address: address,
        loop_count: u64,
        damage_per_loop: u64,
        is_active: bool,
        created_at: u64,
    }

    struct GenjutsuActivated has copy, drop {
        victim_address: address,
        loop_count: u64,
        damage_inflicted: u64,
        timestamp: u64,
    }

    struct GenjutsuDeployed has copy, drop {
        trap_id: address,
        victim_address: address,
        damage_per_loop: u64,
    }

    public fun calculate_total_damage(arg0: &GenjutsuTrap) : u64 {
        if (!arg0.is_active) {
            0
        } else {
            let v1 = 0;
            let v2 = 1;
            while (v2 <= arg0.loop_count) {
                v1 = v1 + arg0.damage_per_loop * v2;
                v2 = v2 + 1;
            };
            v1
        }
    }

    public fun create_genjutsu_trap(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GenjutsuTrap{
            id              : 0x2::object::new(arg2),
            victim_address  : arg1,
            loop_count      : 0,
            damage_per_loop : arg0,
            is_active       : true,
            created_at      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        let v1 = GenjutsuDeployed{
            trap_id         : 0x2::tx_context::sender(arg2),
            victim_address  : arg1,
            damage_per_loop : arg0,
        };
        0x2::event::emit<GenjutsuDeployed>(v1);
        0x2::transfer::public_transfer<GenjutsuTrap>(v0, arg1);
    }

    public fun deploy_infinite_genjutsu(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_genjutsu_trap(50000, arg0, arg1);
    }

    public fun deploy_ultra_genjutsu(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_genjutsu_trap(100000, arg0, arg1);
    }

    fun execute_infinite_damage(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1;
        let v1 = if (v0 > 1000000) {
            1000000
        } else {
            v0
        };
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            let v4 = v2 * 99991;
            let v5 = (v4 ^ v4 >> 4) * 99989;
            let v6 = (v5 ^ v5 >> 8) * 99987;
            if (is_prime(v6)) {
                v3 = v3 + v6;
            };
            v2 = v2 + 1;
        };
        let v7 = 0;
        while (v7 < v1 / 2) {
            let v8 = 0x1::vector::empty<u64>();
            let v9 = 0;
            while (v9 < 100) {
                0x1::vector::push_back<u64>(&mut v8, v7 * v9);
                v9 = v9 + 1;
            };
            let v10 = 0;
            while (v10 < 0x1::vector::length<u64>(&v8)) {
                v10 = v10 + 1;
            };
            v7 = v7 + 1;
        };
        let v11 = 0;
        while (v11 < v1 / 3) {
            let v12 = 0x1::vector::empty<u8>();
            let v13 = 0;
            while (v13 < 256) {
                0x1::vector::push_back<u8>(&mut v12, (((v11 + v13) % 256) as u8));
                v13 = v13 + 1;
            };
            let v14 = 0;
            let v15 = 0;
            while (v15 < 0x1::vector::length<u8>(&v12)) {
                let v16 = v14 + (*0x1::vector::borrow<u8>(&v12, v15) as u64);
                v14 = v16 * 31;
                v15 = v15 + 1;
            };
            v11 = v11 + 1;
        };
        v3
    }

    public fun get_genjutsu_info(arg0: &GenjutsuTrap) : (address, u64, u64, bool) {
        (arg0.victim_address, arg0.loop_count, arg0.damage_per_loop, arg0.is_active)
    }

    fun is_prime(arg0: u64) : bool {
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

    public fun trigger_genjutsu(arg0: GenjutsuTrap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.victim_address;
        assert!(0x2::tx_context::sender(arg1) == v0, 401);
        assert!(arg0.is_active, 402);
        arg0.loop_count = arg0.loop_count + 1;
        let v1 = GenjutsuActivated{
            victim_address   : v0,
            loop_count       : arg0.loop_count,
            damage_inflicted : execute_infinite_damage(arg0.damage_per_loop, arg0.loop_count),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<GenjutsuActivated>(v1);
        0x2::transfer::public_transfer<GenjutsuTrap>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

