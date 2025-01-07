module 0xa1205d8441b4a50a8c70096ff8bd6e493321a0d57f8b212e2bd6e93d5bfa913::shippowifhat {
    struct SHIPPOWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIPPOWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIPPOWIFHAT>(arg0, 6, b"SHIPPOWIFHAT", b"Hippo wifhat", x"686970706f6f6f2c206e69636520746f206d65657420796f750a535549204d4153434f540a484950504f5749464841540a5768696c65206e6f7420666f726d616c6c79207265636f676e697a65642c2073796d626f6c697a657320486970706f2c20746865206d6173636f74206f6620537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_22_at_10_44_42a_am_9cd18bc285.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIPPOWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIPPOWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

