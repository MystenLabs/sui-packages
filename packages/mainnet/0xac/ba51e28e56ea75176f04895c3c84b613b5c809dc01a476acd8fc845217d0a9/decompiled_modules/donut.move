module 0xacba51e28e56ea75176f04895c3c84b613b5c809dc01a476acd8fc845217d0a9::donut {
    struct DONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONUT>(arg0, 6, b"Donut", b"Donut on Sui", b"Meet with $DONUT. The ultimate bite-sized treat on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bonut_5ca9fa3a8d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

