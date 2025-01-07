module 0x97ad3e2475c92a61defd823f35a887a638b18d828aa28fad7c7a2681b25480f3::bald {
    struct BALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALD>(arg0, 6, b"BALD", b"Bald", b"Help me I'm Balding #BaldIsCool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735632017472.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

