module 0x7cf0a002829bb3413401c7fb7a8ed7c75dedf9314bce2d3d5e82ba74c9972f5e::cwal {
    struct CWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWAL>(arg0, 6, b"Cwal", b"Chill Walrus", b"first chill on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cchill_2d589fd4c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

