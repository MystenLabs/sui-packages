module 0x790c4bfb18d06d3ba3daaf88b5277e2b4c7cf74d5763d4c45c84de64462d67a5::sheeesh {
    struct SHEEESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEESH>(arg0, 6, b"SHEEESH", b"SHEESH", b"Sheesh! Chill out bro. Yea, you've found a gem. Yea, you'll have enough money for that lambo you always dreamt of. Yes, yes, you can feed your village. Sheesh. Just join us already...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_14_18_56_44_a6e7668bcb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEEESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

