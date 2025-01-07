module 0x721b249d9d7c79bef7aeeadf081791d5a9ad7843dce0b30be39c3ffcd97dfac3::carlo {
    struct CARLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARLO>(arg0, 6, b"CARLO", b"Carlo Sui", b"Carlo Sui is a clinically insane dog with a pink a**hole.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_24_836b1dc71c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

