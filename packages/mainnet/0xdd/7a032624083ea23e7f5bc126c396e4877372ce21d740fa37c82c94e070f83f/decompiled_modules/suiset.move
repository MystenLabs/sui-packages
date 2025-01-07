module 0xdd7a032624083ea23e7f5bc126c396e4877372ce21d740fa37c82c94e070f83f::suiset {
    struct SUISET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISET>(arg0, 6, b"Suiset", b"SUISET", x"5468652073756e206d6179207365742c20627574205375695365742072697365732120526964652074686520676f6c64656e20676c6f77206f662063727970746f2773206d6f73742072616469616e74206d656d6520636f696e2c207768657265206576657279207472616e73616374696f6e206665656c73206c696b6520612073756e7365742062656163682070617274792e202057686f206e65656473206d6f6f6e73686f7473207768656e20796f752063616e206261736b20696e20746865207761726d7468206f66205375695365743f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123123123123123_fab037edd4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISET>>(v1);
    }

    // decompiled from Move bytecode v6
}

