module 0xf52789ada51b8e5309ab6f64ff7f18283b8f2ae86372bc80642094b78d193eee::b_gold {
    struct B_GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GOLD>(arg0, 9, b"bGOLD", b"bToken GOLD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_GOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

