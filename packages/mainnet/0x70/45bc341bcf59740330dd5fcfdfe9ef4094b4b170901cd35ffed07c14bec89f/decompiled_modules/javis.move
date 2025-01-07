module 0x7045bc341bcf59740330dd5fcfdfe9ef4094b4b170901cd35ffed07c14bec89f::javis {
    struct JAVIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAVIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAVIS>(arg0, 6, b"JAVIS", b"Jarvis.AI", x"4a415256495320284a757374204120526174686572205665727920496e74656c6c6967656e742053797374656d290a4a415256495320697320546f6e7920537461726b277320616476616e6365642041492c20617373697374696e6720696e2065766572797468696e672066726f6d206d616e6167696e6720537461726b20496e647573747269657320746f20636f6e74726f6c6c696e67207468652049726f6e204d616e20737569742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1677_1b61b821ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAVIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAVIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

