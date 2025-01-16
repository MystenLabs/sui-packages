module 0x15d6f00c739e81546e99c9f2b4e6c1e52f5524c4928f6a6fe022b3f57fb59500::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 6, b"FLIP", b"Flip Frenzy", b"Flip, Play and Turbocharge your Fun! Frenzy Flip is a gamified memecoin ecosystem designed for fast-paced community engagement, lighthearted competition, and fun staking mechanics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737033911395.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

