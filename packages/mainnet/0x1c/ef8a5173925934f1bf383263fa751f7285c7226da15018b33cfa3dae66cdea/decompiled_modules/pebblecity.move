module 0x1cef8a5173925934f1bf383263fa751f7285c7226da15018b33cfa3dae66cdea::pebblecity {
    struct PEBBLECITY has drop {
        dummy_field: bool,
    }

    struct Item {
        dummy_field: bool,
    }

    fun init(arg0: PEBBLECITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0 == 0) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>(0)
        };
        0x2::transfer::public_transfer<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::NftTicket<Item>>(0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::claim_ticket<PEBBLECITY, Item>(arg0, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

