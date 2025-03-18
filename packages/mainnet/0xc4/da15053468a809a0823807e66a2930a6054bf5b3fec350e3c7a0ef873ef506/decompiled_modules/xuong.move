module 0xc4da15053468a809a0823807e66a2930a6054bf5b3fec350e3c7a0ef873ef506::xuong {
    struct XUONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUONG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742266778845.png"));
        let (v1, v2) = 0x2::coin::create_currency<XUONG>(arg0, 6, b"XUONG", b"XUONG", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUONG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XUONG>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<XUONG>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XUONG>>(arg0);
    }

    // decompiled from Move bytecode v6
}

