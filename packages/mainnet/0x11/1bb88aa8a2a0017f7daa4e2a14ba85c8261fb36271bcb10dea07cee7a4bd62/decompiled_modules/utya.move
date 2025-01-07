module 0x111bb88aa8a2a0017f7daa4e2a14ba85c8261fb36271bcb10dea07cee7a4bd62::utya {
    struct UTYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTYA>(arg0, 6, b"Utya", b"SUIUTYA", x"245355492024555459412069736e2774206a75737420616e6f74686572206d656d65636f696e2e20497427732061206d6f76656d656e742064726976656e20627920636f6d6d756e6974792c20737072656164696e67206a6f7920616e6420706f7369746976697479207468726f756768207468652069636f6e6963204475636b20456d6f6a692e200a2353554920234d454d45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suita_2f25643362.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UTYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

