module 0x95ee83408462cdb094b06ff9267e2f66a34f03b7d166cceb65bc67aca126e3be::pebblecity {
    struct PEBBLECITY has drop {
        dummy_field: bool,
    }

    struct Showdown_Casino {
        dummy_field: bool,
    }

    fun init(arg0: PEBBLECITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0 == 0) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>(0)
        };
        0x2::transfer::public_transfer<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::NftTicket<Showdown_Casino>>(0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::claim_ticket<PEBBLECITY, Showdown_Casino>(arg0, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

