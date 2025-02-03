module 0x89f358cb728b1369c0f391c085a71c3e6a90471c6eacf3caca78dd6a528f72a9::pebblecity {
    struct PEBBLECITY has drop {
        dummy_field: bool,
    }

    struct SBT {
        dummy_field: bool,
    }

    fun init(arg0: PEBBLECITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0 == 0) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>(0)
        };
        0x2::transfer::public_transfer<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::SbtTicket<SBT>>(0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::claim_ticket<PEBBLECITY, SBT>(arg0, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

