module 0x5bf0d849221a877a612e2af203be418b590afe352c2b33496b76c3470b77602a::hundred {
    struct HUNDRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNDRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNDRED>(arg0, 6, b"HUNDRED", b"100th On SUI", b"100TH launch on Turbos so we get rewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952249471.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUNDRED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNDRED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

