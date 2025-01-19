module 0xeb845480b88d16db5f9767dbd9b2c8c9b0636b6cbbef88ab780fea720bf1f396::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 6, b"Savior", b"Savior Trump", x"536176696f7220446f6e616c64205472756d70206973206865726520746f20736176652074686520776f726c642120546865203437746820707265736964656e74206f66207468652055534120616e64206f757220686f706520666f7220776f726c642070656163652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wegfwrgg_455d53efea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVIOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

