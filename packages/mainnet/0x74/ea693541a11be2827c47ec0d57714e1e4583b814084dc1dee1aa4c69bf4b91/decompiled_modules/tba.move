module 0x74ea693541a11be2827c47ec0d57714e1e4583b814084dc1dee1aa4c69bf4b91::tba {
    struct TBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBA>(arg0, 6, b"TBA", b"TURBOS AKITA", b" Sui's and Turbos's best dog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730966121433.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

