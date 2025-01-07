module 0xb7dd6f7e69c95561622c8aeae4366321a9b74e27c3fe13bdb7e6be2b8e7d7a01::smogfi {
    struct SMOGFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOGFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOGFI>(arg0, 6, b"SMOGFI", b"Smogfi", b"Hi, just lit a cig took a long drag, watched the smoke drift up. Theres somethin about these quiet moments, you know? Just chillin, no rush, no big planslettin life do its thing. Sometimes, its all about kickin back, goin with the flow, and lettin the smoke fade wherever it wants. Its vibes, just real easy vibes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Uy_O5_L_Ms_400x400_1_8d2ea9b086.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOGFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOGFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

