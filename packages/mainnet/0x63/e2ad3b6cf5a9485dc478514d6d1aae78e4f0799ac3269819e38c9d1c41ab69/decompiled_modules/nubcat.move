module 0x63e2ad3b6cf5a9485dc478514d6d1aae78e4f0799ac3269819e38c9d1c41ab69::nubcat {
    struct NUBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBCAT>(arg0, 6, b"Nubcat", b"nubcat", x"6e756220697320612073696c6c792063617420666f72207468652073696c6c69657374206f6620676f6f626572730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6762_62ff13c5b8_0add26e400.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

