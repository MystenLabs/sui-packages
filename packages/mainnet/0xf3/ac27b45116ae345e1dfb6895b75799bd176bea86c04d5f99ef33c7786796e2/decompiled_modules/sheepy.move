module 0xf3ac27b45116ae345e1dfb6895b75799bd176bea86c04d5f99ef33c7786796e2::sheepy {
    struct SHEEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEPY>(arg0, 6, b"SHEEPY", b"Sheepy", x"31207368656570792e2e2e2032207368656570792e2e2e2033206d6f6f6e2e2e2e20f09f9091f09f8c95", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749298753561.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEEPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

