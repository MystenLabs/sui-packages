module 0x98dd621ca86725637495ddd42c68065c1971909b446990fff961da8af992def1::suibear {
    struct SUIBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEAR>(arg0, 6, b"SUIBEAR", b"Bear Cub SUI", b"1111 Bear Cubs born on #SUI blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_T9_Mcwn3_400x400_0800361d41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

