module 0x47c74cb4c15ad8f43f0f566fb8ffbb369c183becf196c0be8e2a515bca04ab19::jailtuah {
    struct JAILTUAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILTUAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAILTUAH>(arg0, 6, b"JAILTUAH", b"JAILTUAH ON SUI", x"48616c6965792057656c6368207573656420746865206361746368706872617365206861776b20747561682e200a0a54696d6520746f20676f20244a41494c545541482e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007417_0a22fa9184.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILTUAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAILTUAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

