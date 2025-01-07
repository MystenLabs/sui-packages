module 0x5e9aaed3e0a1552dd8628e45e62903feeea8890d7f984086c2f3bdaf1891d8b9::wagie {
    struct WAGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGIE>(arg0, 6, b"WAGIE", b"Wagie on sui", b"Are you the choose one to quit your 9-5 $WAGIE?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039328_d72dd3e17c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

