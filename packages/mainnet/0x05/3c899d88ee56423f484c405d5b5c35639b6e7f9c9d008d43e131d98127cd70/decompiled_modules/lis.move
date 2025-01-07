module 0x53c899d88ee56423f484c405d5b5c35639b6e7f9c9d008d43e131d98127cd70::lis {
    struct LIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIS>(arg0, 6, b"LIS", b"LilSui", x"5472696275746520746f20746865206b696e67206f66206372756e6b2e0a0a596565656565616161616161686868686868", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733338884228.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

