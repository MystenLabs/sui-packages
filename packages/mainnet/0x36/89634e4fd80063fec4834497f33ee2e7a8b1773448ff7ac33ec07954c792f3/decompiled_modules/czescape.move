module 0x3689634e4fd80063fec4834497f33ee2e7a8b1773448ff7ac33ec07954c792f3::czescape {
    struct CZESCAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZESCAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZESCAPE>(arg0, 6, b"CZESCAPE", b"CZ Escape SUI", b"Prepare your popcorn and follow CZ's escape to rebuild justice for Sui in the CZ Redemption show!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_dd2f47d916.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZESCAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZESCAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

