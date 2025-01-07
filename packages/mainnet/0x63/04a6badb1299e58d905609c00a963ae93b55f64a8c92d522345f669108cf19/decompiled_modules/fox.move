module 0x6304a6badb1299e58d905609c00a963ae93b55f64a8c92d522345f669108cf19::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"Blue-eyed Fox", b"A blue-eyed fox.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fox_ea59e74d4b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

