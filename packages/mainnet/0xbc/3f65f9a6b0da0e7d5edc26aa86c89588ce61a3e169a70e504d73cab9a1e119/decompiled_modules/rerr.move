module 0xbc3f65f9a6b0da0e7d5edc26aa86c89588ce61a3e169a70e504d73cab9a1e119::rerr {
    struct RERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RERR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741947644641.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<RERR>(arg0, 6, b"rrr", b"rerr", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RERR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RERR>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<RERR>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RERR>>(arg0);
    }

    // decompiled from Move bytecode v6
}

