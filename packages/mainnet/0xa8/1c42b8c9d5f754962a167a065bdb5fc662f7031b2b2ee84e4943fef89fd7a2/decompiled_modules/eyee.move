module 0xa81c42b8c9d5f754962a167a065bdb5fc662f7031b2b2ee84e4943fef89fd7a2::eyee {
    struct EYEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYEE>(arg0, 9, b"EYEE", b"EYE", b"EYEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2a231dc-dea5-46a0-9356-1f8d46446b82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

