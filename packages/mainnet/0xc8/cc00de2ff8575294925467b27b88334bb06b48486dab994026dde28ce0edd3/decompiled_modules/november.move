module 0xc8cc00de2ff8575294925467b27b88334bb06b48486dab994026dde28ce0edd3::november {
    struct NOVEMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVEMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVEMBER>(arg0, 6, b"November", b"November token", b"This month token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6259_db644497ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVEMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOVEMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

