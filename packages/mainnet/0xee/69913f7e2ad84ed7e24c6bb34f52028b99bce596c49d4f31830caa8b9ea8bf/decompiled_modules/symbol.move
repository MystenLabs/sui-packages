module 0xee69913f7e2ad84ed7e24c6bb34f52028b99bce596c49d4f31830caa8b9ea8bf::symbol {
    struct SYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYMBOL>(arg0, 6, b"SYMBOL", b"TOKEN", b"DESC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/ec1dccfc-3d7d-4b5c-ba1f-8c0ca1d41499.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYMBOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYMBOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

