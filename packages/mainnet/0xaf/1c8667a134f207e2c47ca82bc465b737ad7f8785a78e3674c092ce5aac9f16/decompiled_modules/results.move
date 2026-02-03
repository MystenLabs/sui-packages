module 0xaf1c8667a134f207e2c47ca82bc465b737ad7f8785a78e3674c092ce5aac9f16::results {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResultSubmitted has copy, drop {
        telegram_user_id: u64,
        timestamp_sec: u64,
        points: u64,
        user_wallet: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun submit_result(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ResultSubmitted{
            telegram_user_id : arg1,
            timestamp_sec    : arg2,
            points           : arg3,
            user_wallet      : arg4,
        };
        0x2::event::emit<ResultSubmitted>(v0);
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

