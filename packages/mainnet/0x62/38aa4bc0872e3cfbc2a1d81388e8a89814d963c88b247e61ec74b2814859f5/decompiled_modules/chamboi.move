module 0x6238aa4bc0872e3cfbc2a1d81388e8a89814d963c88b247e61ec74b2814859f5::chamboi {
    struct CHAMBOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMBOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMBOI>(arg0, 6, b"Chamboi", b"Chamboi Community own", x"4f727068616e65642061732061206e6577626f726e20696e205355492c200a4368616d626f6920697320612073796d626f6c206f6620726573696c69656e63652e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087104_012f2ae661.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMBOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMBOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

