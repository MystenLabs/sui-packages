module 0x2819530b39dae49d66179521d9cb580a58ad6f0f76f6cdf976ef823ed83e9f6c::uhu {
    struct UHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UHU>(arg0, 6, b"UHU", b"Uhu", b"Fuck all crypto, fuck all jeets this is Uhu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056584_2b8fe8c7dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

