module 0xe024ab7da4cd5082782b1c4cdd26624105a841869b075fbf4c9905e6f4c2ae5e::xuntao {
    struct XUNTAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUNTAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742295404859.png"));
        let (v1, v2) = 0x2::coin::create_currency<XUNTAO>(arg0, 6, b"Xuntao", b"Xuntao", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUNTAO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XUNTAO>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<XUNTAO>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XUNTAO>>(arg0);
    }

    // decompiled from Move bytecode v6
}

