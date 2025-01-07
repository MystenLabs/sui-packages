module 0x900c72fee73034ac67cf3ef7fbc272d4a305da14e844215d4b5d43feed848bec::shibat {
    struct SHIBAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBAT>(arg0, 6, b"SHIBAT", b"Shiba Turbo", b"Shiba Turbo on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956435776.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

