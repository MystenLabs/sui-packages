module 0x53644bb4d195e6f9c1681aca5a32164fea901ca48e8f0e9a6c5e7bd8e1b2ae20::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE>(arg0, 9, b"TESTING", b"test", b"test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jurassiq-prod.s3.eu-north-1.amazonaws.com/KickIcon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

