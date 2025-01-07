module 0x3be6c727f38d128b651c71323b3de671e62544f530748af3fbc221ec55a7f161::lunax {
    struct LUNAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNAX>(arg0, 6, b"Lunax", b"Luna", b"The new luna by Do kuy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731603329680.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUNAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

