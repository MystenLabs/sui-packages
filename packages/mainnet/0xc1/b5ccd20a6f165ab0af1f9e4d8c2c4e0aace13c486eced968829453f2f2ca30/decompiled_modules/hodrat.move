module 0xc1b5ccd20a6f165ab0af1f9e4d8c2c4e0aace13c486eced968829453f2f2ca30::hodrat {
    struct HODRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODRAT>(arg0, 6, b"HODRAT", b"Hodrat On Sui", b"The True Name of the bat-like in The Night riders Revealed HODRAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021167_5dea39401d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

