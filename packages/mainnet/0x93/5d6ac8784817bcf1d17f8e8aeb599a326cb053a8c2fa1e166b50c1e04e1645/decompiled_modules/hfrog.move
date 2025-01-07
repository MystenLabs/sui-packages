module 0x935d6ac8784817bcf1d17f8e8aeb599a326cb053a8c2fa1e166b50c1e04e1645::hfrog {
    struct HFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFROG>(arg0, 6, b"HFROG", b"HopFrogOnSui", b"First Frog on Hop Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frog_db5a0e033e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

