module 0xb10b1c2f25bcbcc6ce830abec993c4a1bb72b67afc3233677983a4cd997eaeb1::skc {
    struct SKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKC>(arg0, 6, b"SKC", b"Cat Kill Sui", b"Cat killed Sui and is taking over.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CCO_456683a708.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

