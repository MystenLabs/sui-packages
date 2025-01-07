module 0x806b2327185d2e1a6592a7bbf7c95e675744d76aca6d6135104946bc76747f12::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAN>(arg0, 6, b"Evan", b"Evan Sui", b"Evan Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3g_DJWZ_1_X_400x400_7e0711b0a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

