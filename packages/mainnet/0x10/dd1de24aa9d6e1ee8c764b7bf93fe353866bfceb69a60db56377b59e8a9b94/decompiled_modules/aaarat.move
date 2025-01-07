module 0x10dd1de24aa9d6e1ee8c764b7bf93fe353866bfceb69a60db56377b59e8a9b94::aaarat {
    struct AAARAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAARAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAARAT>(arg0, 6, b"AAARAT", b"AaaRat", b"AaaAAAAAAaaAaaAAaaAAaaAAAaaAAAaAAaaCheese", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_20_09_18_ab5efa9aa0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAARAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAARAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

