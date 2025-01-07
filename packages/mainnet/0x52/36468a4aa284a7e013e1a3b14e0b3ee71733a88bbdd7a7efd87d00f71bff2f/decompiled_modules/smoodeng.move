module 0x5236468a4aa284a7e013e1a3b14e0b3ee71733a88bbdd7a7efd87d00f71bff2f::smoodeng {
    struct SMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOODENG>(arg0, 6, b"SMOODENG", b"sui moo deng", b"moo deng on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimoodeng_c927a9d508.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

