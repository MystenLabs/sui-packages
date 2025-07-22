module 0x215fd79859356df9e32e39b113ec6f72f974dc4a5ce93b38cf4014d46e0c5be7::wen {
    struct WEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WEN>(arg0, 6, b"WEN", b"wen", b"@suilaunchcoin $wen + wen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/wen-zt2h6e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

