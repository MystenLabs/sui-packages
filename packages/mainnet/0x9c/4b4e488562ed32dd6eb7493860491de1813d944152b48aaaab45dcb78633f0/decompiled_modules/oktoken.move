module 0x9c4b4e488562ed32dd6eb7493860491de1813d944152b48aaaab45dcb78633f0::oktoken {
    struct OKTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742294549879.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<OKTOKEN>(arg0, 6, b"TT", b"OkToken", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKTOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKTOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<OKTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OKTOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

