module 0x402bbdfd137524994bbc9c0899639a264da6aad962bf7bca930d054352873e92::mushy {
    struct MUSHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHY>(arg0, 6, b"MUSHY", b"MUSHY ON SUI", x"47657420726561647920746f206d616b652063727970746f2066616e74617374696320616761696e2077697468204d555348590a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3577_2e0efbbcd2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

