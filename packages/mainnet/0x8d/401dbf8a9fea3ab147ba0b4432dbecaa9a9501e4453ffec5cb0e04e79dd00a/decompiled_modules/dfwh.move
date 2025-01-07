module 0x8d401dbf8a9fea3ab147ba0b4432dbecaa9a9501e4453ffec5cb0e04e79dd00a::dfwh {
    struct DFWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFWH>(arg0, 6, b"DFWH", b"Drinking fish with hat", x"546865206d6f73742072656c61786564206669736820776974682061206861742e0a48652773206e616d6520697320526f626572746f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026796_578fe18f19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

