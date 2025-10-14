module 0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONEY>(arg0, 6, b"HONEY", b"HONEY", x"54686520636f6f7264696e6174696f6e20617373657420666f7220486f6e6579506c6179e28094747265617375726965732c2074617865732c206275796261636b732c20616e642075736572207265776172647320696e206f6e65206465666c6174696f6e61727920746f6b656e2e20f09f8fb4e2808de298a0efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d13jtsearj5tgw.cloudfront.net/assets/HoneyPlay_Logo_Animation.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

