module 0x8654bbd4ed8ceb9a9637aef91b4f89ed473a9b7da5323b1946427e884079093f::jays {
    struct JAYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAYS>(arg0, 6, b"JAYS", b"Sui Jays", b"Sui Jays are your feathery companions in the vast oceans of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731628737774.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

