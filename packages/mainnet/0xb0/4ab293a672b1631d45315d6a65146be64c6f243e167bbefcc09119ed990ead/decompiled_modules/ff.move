module 0xb04ab293a672b1631d45315d6a65146be64c6f243e167bbefcc09119ed990ead::ff {
    struct FF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FF>(arg0, 6, b"FF", b"FUCKFUNS", b"FUCKFUNS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956643397.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

