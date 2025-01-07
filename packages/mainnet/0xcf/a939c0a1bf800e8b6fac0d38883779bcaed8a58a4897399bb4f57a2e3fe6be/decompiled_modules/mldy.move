module 0xcfa939c0a1bf800e8b6fac0d38883779bcaed8a58a4897399bb4f57a2e3fe6be::mldy {
    struct MLDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLDY>(arg0, 6, b"MLDY", b"MILADY", b"The mozt popularized MemeArt Landing on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240413_225107_732fdc8179.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

