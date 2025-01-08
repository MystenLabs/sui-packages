module 0x40daa447b67184c910aedda03becfb23c40b945b8533a57218bac85f130a8c28::xmoney {
    struct XMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMONEY>(arg0, 6, b"Xmoney", b"X Money", x"52696465207468652077617665206f6e20456c6f6e732062696767657374206164646974696f6e20746f20746865205820706c6174666f726d2e2020546869732077696c6c2061207574696c6974792074616c6b65642061626f757420666f7220796561727320200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4579_a17c5ef3b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

