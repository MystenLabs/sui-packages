module 0x7d6f81f1d1b2d556fe0b48d822c64ef310633f94ceff65a65798ff9ce46d5397::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"SQUID", b"Demolition Squid", x"446566656e64696e6720796f752066726f6d2074686520747972616e6e79206f6620686f757365732c206974277320777265636b696e672074696d652e20497427732044656d6f6c6974696f6e2053717569642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ijx_Rx_ZQ_9_400x400_b2c3e5fc6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

