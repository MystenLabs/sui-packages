module 0xc6104f633775496ffc5bbb0e673db06916fad703b19e27521effb7bccd61b083::coin_bait {
    struct CoinBait has store, key {
        id: 0x2::object::UID,
        bait_coin: 0x2::coin::Coin<0x2::sui::SUI>,
        trigger_count: u64,
        max_triggers: u64,
        owner: address,
    }

    struct BaitTriggered has copy, drop {
        owner: address,
        trigger_count: u64,
        bait_value: u64,
        gas_consumed: u64,
    }

    public fun create_coin_bait(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : CoinBait {
        CoinBait{
            id            : 0x2::object::new(arg2),
            bait_coin     : 0x2::coin::zero<0x2::sui::SUI>(arg2),
            trigger_count : 0,
            max_triggers  : arg1,
            owner         : 0x2::tx_context::sender(arg2),
        }
    }

    public fun estimate_remaining_damage(arg0: &CoinBait) : u64 {
        if (arg0.trigger_count >= arg0.max_triggers) {
            0
        } else {
            let v1 = 0;
            let v2 = 1;
            while (v2 <= arg0.max_triggers - arg0.trigger_count) {
                v1 = v1 + (arg0.trigger_count + v2) * 5000 * 25;
                v2 = v2 + 1;
            };
            v1
        }
    }

    fun execute_gas_drain(arg0: u64) : u64 {
        let v0 = arg0 * 5000;
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = v1 * 9973;
            let v4 = (v3 ^ v3 >> 16) * 12345;
            let v5 = 2;
            let v6 = v4 ^ v4 >> 8;
            while (v5 < 50 && v5 * v5 <= v6) {
                while (v6 % v5 == 0) {
                    v6 = v6 / v5;
                };
                v5 = v5 + 1;
            };
            v2 = v2 + v6;
            v1 = v1 + 1;
        };
        v0 * 25
    }

    public fun get_bait_info(arg0: &CoinBait) : (address, u64, u64, u64, u64) {
        let v0 = if (arg0.trigger_count >= arg0.max_triggers) {
            0
        } else {
            1
        };
        (arg0.owner, arg0.trigger_count, arg0.max_triggers, 0x2::coin::value<0x2::sui::SUI>(&arg0.bait_coin), v0)
    }

    public fun is_active(arg0: &CoinBait) : bool {
        arg0.trigger_count < arg0.max_triggers
    }

    public fun trigger_bait(arg0: CoinBait, arg1: &mut 0x2::tx_context::TxContext) : CoinBait {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 401);
        assert!(arg0.trigger_count < arg0.max_triggers, 402);
        arg0.trigger_count = arg0.trigger_count + 1;
        let v0 = BaitTriggered{
            owner         : arg0.owner,
            trigger_count : arg0.trigger_count,
            bait_value    : 0x2::coin::value<0x2::sui::SUI>(&arg0.bait_coin),
            gas_consumed  : execute_gas_drain(arg0.trigger_count),
        };
        0x2::event::emit<BaitTriggered>(v0);
        arg0
    }

    // decompiled from Move bytecode v6
}

