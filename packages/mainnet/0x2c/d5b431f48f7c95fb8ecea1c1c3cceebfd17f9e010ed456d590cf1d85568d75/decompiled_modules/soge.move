module 0x2cd5b431f48f7c95fb8ecea1c1c3cceebfd17f9e010ed456d590cf1d85568d75::soge {
    struct SOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGE>(arg0, 6, b"SOGE", b"SUI DOGE", b"Soge, Sui Doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOGE_a38fe0f8b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

