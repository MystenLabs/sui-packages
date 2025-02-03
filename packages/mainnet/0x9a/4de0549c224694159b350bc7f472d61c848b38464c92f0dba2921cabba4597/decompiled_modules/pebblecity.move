module 0x9a4de0549c224694159b350bc7f472d61c848b38464c92f0dba2921cabba4597::pebblecity {
    struct PEBBLECITY has drop {
        dummy_field: bool,
    }

    struct JackpotPlanet_Casino {
        dummy_field: bool,
    }

    fun init(arg0: PEBBLECITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0 == 0) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>(0)
        };
        0x2::transfer::public_transfer<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::NftTicket<JackpotPlanet_Casino>>(0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::claim_ticket<PEBBLECITY, JackpotPlanet_Casino>(arg0, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

