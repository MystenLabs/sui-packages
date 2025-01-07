module 0xaf261fbb1a44b52bd51af3335ce4d846668f775ecbd64de9c56630aef2a0f083::snl {
    struct SNL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNL>(arg0, 6, b"SNL", b"Slow and Steady Sui", b"The image depicts a snail carrying Sui tokens, symbolizing a unique perspective on investing and the potential for growth, even at a slow pace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733074565101.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

