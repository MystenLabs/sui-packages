module 0x6e31d5d56b5a3d68ff03676ab58f5844b969936fb9a975ce3531b90b12b755bb::suinut {
    struct SUINUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINUT>(arg0, 6, b"SUINUT", b"Sui Peanut", x"546865204f472024504e555420696e737069726564206279205065616e75742074686520737175697272656c2073696e6365204d617263682032303234204a75737469636520666f72205065616e75742e20f09fa59c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973853086.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

