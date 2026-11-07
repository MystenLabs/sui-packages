module 0x8e4ccefa989627261a8ce62b24f2139eedba9f6d0030f7c7e670bdf1feea844c::probe {
    struct Probe has copy, drop {
        sender: address,
        run_id: address,
        sequence: u64,
        client_prepare_wall_ms: u64,
        onchain_clock_ms: u64,
    }

    public fun mark(arg0: address, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2::event::emit<Probe>(receipt(arg0, arg1, arg2, arg3, arg4));
    }

    fun receipt(arg0: address, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : Probe {
        Probe{
            sender                 : 0x2::tx_context::sender(arg4),
            run_id                 : arg0,
            sequence               : arg1,
            client_prepare_wall_ms : arg2,
            onchain_clock_ms       : 0x2::clock::timestamp_ms(arg3),
        }
    }

    // decompiled from Move bytecode v7
}

