module 0x4d96da9bd0247297916f3cdc3b97c4dae8a554a96a412344e59b0c23dd69cfe1::hhh {
    struct HHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHH>(arg0, 6, b"HHH", b"vhhbjbk", b" nnbbkkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a19c1bd8_87a9_44c4_983c_c90ac006f8e7_47e4dcc68a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

