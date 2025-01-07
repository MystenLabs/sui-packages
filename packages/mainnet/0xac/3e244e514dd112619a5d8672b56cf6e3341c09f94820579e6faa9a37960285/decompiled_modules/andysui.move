module 0xac3e244e514dd112619a5d8672b56cf6e3341c09f94820579e6faa9a37960285::andysui {
    struct ANDYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDYSUI>(arg0, 6, b"AndySui", b"Andy Sui", b"Legendary Andy has come to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GSSTS_0f_Xs_AE_4vdw_afbfa03fd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

