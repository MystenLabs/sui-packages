module 0x452af6cb7616ef10d240fefda5ebe10de7c96cdc943af514c586361e478b5539::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 6, b"Wojak", b"Wojak on Sui", b"Wojak is on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734888270081.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

