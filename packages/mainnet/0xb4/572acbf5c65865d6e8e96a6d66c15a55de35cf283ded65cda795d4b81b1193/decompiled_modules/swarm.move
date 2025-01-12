module 0xb4572acbf5c65865d6e8e96a6d66c15a55de35cf283ded65cda795d4b81b1193::swarm {
    struct SWARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM>(arg0, 6, b"SWARM", b"SuiSwarm", x"f09f909d20456d706f776572696e67206368616e676520776974682024535741524d3a2043727970746f206d65657473207375737461696e6162696c6974792e20536176696e6720626565732c20737570706f7274696e672074686520706c616e65742c20616e64206275696c64696e6720612062757a7a696e6720626c6f636b636861696e20636f6d6d756e6974792e20f09f8c8df09f9a8020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736644701864.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWARM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

