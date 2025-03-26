module 0xe7a80776794be7412f23928d76f53b66ec136f4f008a7d6e9a267ab4ba8238bf::asdf {
    struct ASDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDF>(arg0, 6, b"ASDF", b"ADS", b"ASDFSDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_63e93a458c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

