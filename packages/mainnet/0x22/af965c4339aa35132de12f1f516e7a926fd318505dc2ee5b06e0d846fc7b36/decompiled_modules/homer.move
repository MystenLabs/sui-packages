module 0x22af965c4339aa35132de12f1f516e7a926fd318505dc2ee5b06e0d846fc7b36::homer {
    struct HOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMER>(arg0, 6, b"HOMER", b"Homer Trump", x"486f6d65722053696d70736f6e20697320612070726f70686574210a496e20746865203230313520657069736f646520274261727420746f207468652046757475726527206f6620275468652053696d70736f6e73272c2061207363656e652073686f77732061207369676e20696e20746865206261636b67726f756e64207468617420726561647320275472756d702032303234272c2070726564696374696e6720446f6e616c64205472756d702773203230323420707265736964656e7469616c2072756e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_17_55_38_f32ce06fd7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

