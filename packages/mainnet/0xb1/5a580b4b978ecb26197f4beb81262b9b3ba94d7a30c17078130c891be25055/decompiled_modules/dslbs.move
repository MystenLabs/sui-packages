module 0xb15a580b4b978ecb26197f4beb81262b9b3ba94d7a30c17078130c891be25055::dslbs {
    struct DSLBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSLBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSLBS>(arg0, 6, b"DSLBS", b"DeSuiLabs", b"A creative gaming studio for misfits Winx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdfa_a8b78a1b7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSLBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSLBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

