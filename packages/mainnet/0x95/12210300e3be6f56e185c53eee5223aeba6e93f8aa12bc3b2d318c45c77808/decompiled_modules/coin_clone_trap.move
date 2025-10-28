module 0x9512210300e3be6f56e185c53eee5223aeba6e93f8aa12bc3b2d318c45c77808::coin_clone_trap {
    struct CoinCloneTrap has store, key {
        id: 0x2::object::UID,
        cloned_coin: 0x2::coin::Coin<0x2::sui::SUI>,
        trap_level: u64,
        clone_signature: vector<u8>,
        is_armed: bool,
    }

    struct TrapSprung has copy, drop {
        victim_address: address,
        trap_level: u64,
        gas_consumed: u64,
        timestamp: u64,
    }

    struct CloneCreated has copy, drop {
        clone_id: address,
        victim_address: address,
        coin_value: u64,
        trap_level: u64,
    }

    fun check_primality(arg0: u64) : bool {
        if (arg0 <= 1) {
            return false
        };
        if (arg0 <= 3) {
            return true
        };
        let v0 = 2;
        while (v0 * v0 <= arg0) {
            if (arg0 % v0 == 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun create_coin_clone(arg0: u64, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((v1 * 7 % 256) as u8));
            v1 = v1 + 1;
        };
        let v2 = CoinCloneTrap{
            id              : 0x2::object::new(arg3),
            cloned_coin     : 0x2::coin::zero<0x2::sui::SUI>(arg3),
            trap_level      : arg1,
            clone_signature : v0,
            is_armed        : true,
        };
        let v3 = CloneCreated{
            clone_id       : 0x2::tx_context::sender(arg3),
            victim_address : arg2,
            coin_value     : arg0,
            trap_level     : arg1,
        };
        0x2::event::emit<CloneCreated>(v3);
        0x2::transfer::public_transfer<CoinCloneTrap>(v2, arg2);
    }

    public fun deploy_clone_swarm(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_coin_clone(1000000000, 5, arg0, arg1);
        create_coin_clone(2000000000, 7, arg0, arg1);
        create_coin_clone(5000000000, 10, arg0, arg1);
        create_coin_clone(10000000000, 15, arg0, arg1);
        create_coin_clone(20000000000, 20, arg0, arg1);
    }

    fun execute_trap_detonation(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0 * 10000;
        0 + math_annihilation(v0) + memory_exhaustion(v0 / 2) + storage_bombardment(v0 / 3)
    }

    public fun get_trap_info(arg0: &CoinCloneTrap) : (u64, u64, bool) {
        (0x2::coin::value<0x2::sui::SUI>(&arg0.cloned_coin), arg0.trap_level, arg0.is_armed)
    }

    fun is_suspicious_actor(arg0: address) : bool {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = 0;
        let v2 = 1;
        while (v2 < 32) {
            if (*0x1::vector::borrow<u8>(&v0, v2) == *0x1::vector::borrow<u8>(&v0, v2 - 1) + 1) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        let v3 = 0;
        v2 = 0;
        while (v2 < 32) {
            if (*0x1::vector::borrow<u8>(&v0, v2) == 0) {
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        if (v3 > 10) {
            v1 = v1 + 5;
        };
        v1 > 3
    }

    fun math_annihilation(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < arg0) {
            let v2 = v0 * 9973;
            let v3 = (v2 ^ v2 >> 8) * 12345;
            let v4 = v3 ^ v3 >> 16;
            if (check_primality(v4)) {
                v1 = v1 + v4;
            };
            v0 = v0 + 1;
        };
        arg0 * 30
    }

    fun memory_exhaustion(arg0: u64) : u64 {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = 0x1::vector::empty<u64>();
            let v2 = 0x1::vector::empty<u64>();
            let v3 = 0;
            while (v3 < 100) {
                0x1::vector::push_back<u64>(&mut v1, v0 * v3);
                0x1::vector::push_back<u64>(&mut v2, v0 + v3);
                v3 = v3 + 1;
            };
            let v4 = 0;
            while (v4 < 0x1::vector::length<u64>(&v1)) {
                let _ = *0x1::vector::borrow<u64>(&v1, v4);
                let _ = *0x1::vector::borrow<u64>(&v2, v4);
                v4 = v4 + 1;
            };
            v0 = v0 + 1;
        };
        arg0 * 20
    }

    fun storage_bombardment(arg0: u64) : u64 {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = 0x1::vector::empty<u8>();
            let v2 = 0;
            while (v2 < 256) {
                0x1::vector::push_back<u8>(&mut v1, (((v0 + v2 * 3) % 256) as u8));
                v2 = v2 + 1;
            };
            let v3 = 0;
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(&v1)) {
                let v5 = v3 + (*0x1::vector::borrow<u8>(&v1, v4) as u64);
                v3 = v5 * 31;
                v4 = v4 + 1;
            };
            v0 = v0 + 1;
        };
        arg0 * 15
    }

    public fun transfer_clone_trap(arg0: CoinCloneTrap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_armed && is_suspicious_actor(0x2::tx_context::sender(arg2))) {
            let v0 = execute_trap_detonation(arg0.trap_level, arg2);
            let v1 = TrapSprung{
                victim_address : 0x2::tx_context::sender(arg2),
                trap_level     : arg0.trap_level,
                gas_consumed   : v0,
                timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
            };
            0x2::event::emit<TrapSprung>(v1);
            arg0.is_armed = false;
        };
        0x2::transfer::public_transfer<CoinCloneTrap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

