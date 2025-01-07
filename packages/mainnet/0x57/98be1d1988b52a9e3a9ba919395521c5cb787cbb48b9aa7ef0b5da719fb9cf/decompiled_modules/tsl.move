module 0x5798be1d1988b52a9e3a9ba919395521c5cb787cbb48b9aa7ef0b5da719fb9cf::tsl {
    struct TSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSL>(arg0, 6, b"TSL", b"The Sui Legend", b"The Legend Of sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013580_290f94ba5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

