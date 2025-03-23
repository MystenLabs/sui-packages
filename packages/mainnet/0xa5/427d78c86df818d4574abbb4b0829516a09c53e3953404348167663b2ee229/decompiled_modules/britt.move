module 0xa5427d78c86df818d4574abbb4b0829516a09c53e3953404348167663b2ee229::britt {
    struct BRITT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRITT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRITT>(arg0, 6, b"BRITT", b"Britt", b"Britt golden", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000628_b0ae49744f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRITT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRITT>>(v1);
    }

    // decompiled from Move bytecode v6
}

