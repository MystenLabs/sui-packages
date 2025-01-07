module 0x9abd76776f9d24c275eb5d69cb554b91ca6b39f637695dcb4c3901c85d501984::pooti {
    struct POOTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOTI>(arg0, 6, b"Pooti", b"POOTI GANG", x"68747470733a2f2f7777772e696e7374616772616d2e636f6d2f7265656c2f4338355058494e417455432f3f696773683d4d5456746432746e4d5856774f54647164513d3d200a0a53686f7720736f6d65206c6f766520746f2044796c616e73206e6577207669642065766572796f6e652e200a5065726368697461206265656e206669676874696e6720666f7220686973206c6966652e0a426f726e2061206669676874657220616c7761797320612066696768746572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3063_fb55dfc0ec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

