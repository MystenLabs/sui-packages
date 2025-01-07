module 0x6b2c12565e17c5875c82e86e5a4a45815c99ac1df5665a7ed5f7ae313e51aa1e::nets {
    struct NETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NETS>(arg0, 6, b"NETS", b"Fishing Nets", b"Fill your bags with fishing nets!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731537154115.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NETS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NETS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

