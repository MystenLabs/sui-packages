module 0xc9cff49ade6bb3be10d85175766e8609679d4af6a7760caefa1f99bf85d27b2e::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TRUMPSUI", b"Sui Trump Nation", b"Its me, Donald J. Trumpback, stronger than ever! In 2025, Ill stand on that inauguration stage, leading Trump Nation to even greater heights. Together, we fight, fight! and prove that nothing can stop us. Believe me, the best is yet to come.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_034755_156_5577fa38dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

