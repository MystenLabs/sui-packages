module 0xddf59cc9ad92d3d9c9fed04911dee0248d2bc586661df0c68d601c6b14c34903::tang {
    struct TANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TANG>(arg0, 6, b"TANG", b"Tang Cat", x"2454414e4720746865206d656d6520636f696e2061626f7574206120636174206e616d65642054616e677975616e20776974682061206465666f726d6564207061772e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gw_UUY_Xw_F_400x400_800efba1c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

