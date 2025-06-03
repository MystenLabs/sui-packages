module 0x1d3829455b6eb5fec20d28932c12d3a89d4a62611fea84d397981c3ca8a63162::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"lmtoken", b"happy fox", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tai_xuong_7528fb4252.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

