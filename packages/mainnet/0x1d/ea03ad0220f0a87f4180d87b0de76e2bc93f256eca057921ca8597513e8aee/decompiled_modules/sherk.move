module 0x1dea03ad0220f0a87f4180d87b0de76e2bc93f256eca057921ca8597513e8aee::sherk {
    struct SHERK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHERK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHERK>(arg0, 6, b"SHERK", b"SHARK IN SUI", b"SHARK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sherk_087320b0a8_ff915ca989.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHERK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHERK>>(v1);
    }

    // decompiled from Move bytecode v6
}

