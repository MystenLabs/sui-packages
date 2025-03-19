module 0x8dcb79f122060d58c0cb23aa850d5b7ab7d5d449a94d33178926420a81bd2135::moimoimoi {
    struct MOIMOIMOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOIMOIMOI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742371889117.png"));
        let (v1, v2) = 0x2::coin::create_currency<MOIMOIMOI>(arg0, 6, b"MOIMOIMOI", b"MOIMOIMOI", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOIMOIMOI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOIMOIMOI>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MOIMOIMOI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOIMOIMOI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

