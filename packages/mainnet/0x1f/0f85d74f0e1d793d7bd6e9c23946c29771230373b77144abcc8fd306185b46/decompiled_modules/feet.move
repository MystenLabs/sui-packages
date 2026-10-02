module 0x1f0f85d74f0e1d793d7bd6e9c23946c29771230373b77144abcc8fd306185b46::feet {
    struct FEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEET>(arg0, 9, b"Feet", b"Feet", b"Feet of Co-founder of SuiPump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipads.fun/api/files/suipump/logos/0x159ca760875b2e1713b7132559e0f50bc9e29a4e310816bc0683ab425ea814ce/070c9c37-9d1a-4bce-a79a-6683916ae7ad.jpeg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FEET>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEET>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

