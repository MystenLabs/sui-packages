module 0xb64a6352ea92c500a1edf109634fa96d5b49968be448c5e49c08dc7f8523292::nubb {
    struct NUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBB>(arg0, 6, b"NUBB", b"Sui Nubb", b"Meet Nubb, a cute, quirky, loving creature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731042059392.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

