module 0xc48f5032ef134da9c29d0a0c311c36c03e879ac83e38d2c63cb55fc89c07b12e::rabbit {
    struct RABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT>(arg0, 6, b"RABBIT", b"SUIRABBIT", b"HOP HOP HOP HOP HOP HOP HOP HOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955200403.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABBIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

