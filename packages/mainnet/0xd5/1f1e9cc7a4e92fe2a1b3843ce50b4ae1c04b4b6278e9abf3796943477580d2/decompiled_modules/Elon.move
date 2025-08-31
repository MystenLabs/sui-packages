module 0xd51f1e9cc7a4e92fe2a1b3843ce50b4ae1c04b4b6278e9abf3796943477580d2::Elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 9, b"ELON", b"Elon", b"elon flag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzqxXfMaYAA4TMb?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

