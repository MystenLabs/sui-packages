module 0x5b00119e01a4ba5c9c06381cce2fca34faaa7bac3a3b845d6fcd6a77e3e7c8da::Convoy {
    struct Formation has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        mission: u8,
        cohort_id: u64,
        home_id: u64,
        destination_id: u64,
        speed: u8,
        proof: u64,
    }

    public fun Cohort(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Formation{
            patarian_id    : arg2,
            phantom_addr   : 0x2::tx_context::sender(arg7),
            mission        : arg0,
            cohort_id      : arg1,
            home_id        : arg3,
            destination_id : arg4,
            speed          : arg5,
            proof          : arg6,
        };
        0x2::event::emit<Formation>(v0);
    }

    // decompiled from Move bytecode v6
}

