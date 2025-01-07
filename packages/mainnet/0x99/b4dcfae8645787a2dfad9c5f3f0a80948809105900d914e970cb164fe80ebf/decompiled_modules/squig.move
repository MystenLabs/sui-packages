module 0x99b4dcfae8645787a2dfad9c5f3f0a80948809105900d914e970cb164fe80ebf::squig {
    struct SQUIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIG>(arg0, 6, b"SQUIG", b"SquidGirl", b"Squid Girl, the fearless superhero in Shinryaku! Ika Musume, emerges to save the sea from human pollution. She is taking over the entire SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_00_07_05_33eda5abcd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

