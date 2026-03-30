module 0x45d5fcaaa46f78b33665e351f7de04c3f9b5be9d058f183dd86c8b69cca5fa60::husdc {
    struct HUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSDC>(arg0, 9, b"husdc", b"husdc Coin", b"husdc Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-testnet.haedal.xyz/htoken/husdc.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

