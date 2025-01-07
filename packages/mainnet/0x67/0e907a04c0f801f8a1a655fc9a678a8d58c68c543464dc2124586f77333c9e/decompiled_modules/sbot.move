module 0x670e907a04c0f801f8a1a655fc9a678a8d58c68c543464dc2124586f77333c9e::sbot {
    struct SBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOT>(arg0, 6, b"SBOT", b"SUI Bridge Bot", x"4578706c6f726520245342422c2074686520756c74696d617465207574696c69747920746f6b656e206f6e205355492c0a6272696467696e672074686520676170206265747765656e0a416c6c20636861696e7320616e6420535549207365616d6c6573736c792e0a4566666f72746c6573736c79207472616e7366657220796f7572206173736574732077697468206561736521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sbot_1e4e6307f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

