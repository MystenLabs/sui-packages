module 0xb39de15e8d02aecf649fe19abc6dcf9d0da0868c5493ff45dd976c542f351ed1::zora {
    struct ZORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORA>(arg0, 6, b"ZORA", b"wenZORA", b"express yourself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZORA_b2f87b02ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

