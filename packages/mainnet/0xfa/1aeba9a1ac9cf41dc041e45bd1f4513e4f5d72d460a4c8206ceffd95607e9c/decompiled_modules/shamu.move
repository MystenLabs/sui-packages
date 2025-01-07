module 0xfa1aeba9a1ac9cf41dc041e45bd1f4513e4f5d72d460a4c8206ceffd95607e9c::shamu {
    struct SHAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAMU>(arg0, 6, b"Shamu", b"Shamu Sui", x"57656c636f6d65204d797374657272696572690a0a245368616d752069732074686520756c74696d617465206d656d65636f696e0a666f72207468652062696767657374207768616c657320696e207468650a63727970746f20776f726c642c20706179696e6720686f6d61676520746f0a746865206d6f73742066616d6f7573207768616c65206f6620616c6c2074696d653a0a5368616d752e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000066739_c6f4d32cf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

