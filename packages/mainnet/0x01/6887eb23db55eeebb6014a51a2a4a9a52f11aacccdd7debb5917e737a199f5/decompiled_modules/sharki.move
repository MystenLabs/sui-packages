module 0x16887eb23db55eeebb6014a51a2a4a9a52f11aacccdd7debb5917e737a199f5::sharki {
    struct SHARKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKI>(arg0, 6, b"Sharki", b"Sharki on SUI", x"536861726b692074686520536861726b73210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_W_Igwh_Mk_400x400_675d377b4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

