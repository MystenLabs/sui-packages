module 0xd0e2ade7ee32806c5a6f54542e130976b6606a243049c3c4f3233af2ecb5e506::xun {
    struct XUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742265021997.png"));
        let (v1, v2) = 0x2::coin::create_currency<XUN>(arg0, 6, b"XUN", b"XUN", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XUN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<XUN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XUN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

