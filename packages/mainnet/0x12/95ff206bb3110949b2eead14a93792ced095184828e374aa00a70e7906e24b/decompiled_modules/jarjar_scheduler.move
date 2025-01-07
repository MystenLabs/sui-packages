module 0x1295ff206bb3110949b2eead14a93792ced095184828e374aa00a70e7906e24b::jarjar_scheduler {
    struct ScheduleEvent has copy, drop {
        execution_time: u64,
        execution_path: 0x1::string::String,
        amount: u64,
        params_id: address,
    }

    struct JARJAR_SCHEDULER has drop {
        dummy_field: bool,
    }

    public fun emit_scheduled_task_event(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: address, arg4: 0x2::coin::Coin<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>) {
        assert!(0x2::coin::value<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>(&arg4) > 1 * 1000000000, 1);
        let v0 = ScheduleEvent{
            execution_time : arg1,
            execution_path : arg0,
            amount         : arg2,
            params_id      : arg3,
        };
        0x2::event::emit<ScheduleEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc288caf405af52affcff65150c81e1c584453c0c13cbf3a938f51282a37e7031::binks::BINKS>>(arg4, @0x4b0d62f8d195e018fc43a47ae9b493bef6ff6ec06c50dcc5219e14f249b3e65a);
    }

    fun init(arg0: JARJAR_SCHEDULER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<JARJAR_SCHEDULER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

