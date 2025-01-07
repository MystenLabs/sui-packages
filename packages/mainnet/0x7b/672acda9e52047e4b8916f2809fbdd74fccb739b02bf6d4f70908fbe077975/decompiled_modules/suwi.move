module 0x7b672acda9e52047e4b8916f2809fbdd74fccb739b02bf6d4f70908fbe077975::suwi {
    struct SUWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWI>(arg0, 6, b"SUWI", b"SUWI on SUI", b"Meet Suwi, your daily dose of good vibes and sunshine!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_B_Uuzt_Ug_400x400_c601005622.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

