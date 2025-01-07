module 0x86ec46714c5f355a9fbba9c24464439f4550a979abf5383c059449c0f24cecf1::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"GME on SUI", b"Home of the Degens of Wall Street.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gamestop_0187ae18c9_f6bb7b11d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GME>>(v1);
    }

    // decompiled from Move bytecode v6
}

