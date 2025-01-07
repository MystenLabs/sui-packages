module 0x922f2798f01d7c0372e964ba2f6f3967f6cf8b67f82b3046a534240f3af6e04d::nub {
    struct NUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUB>(arg0, 6, b"NUB", b"Nubcat", b"silly nub art", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731110480336.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

