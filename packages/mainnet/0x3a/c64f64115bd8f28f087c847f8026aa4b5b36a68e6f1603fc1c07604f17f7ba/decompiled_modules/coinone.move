module 0x3ac64f64115bd8f28f087c847f8026aa4b5b36a68e6f1603fc1c07604f17f7ba::coinone {
    struct COINONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINONE>(arg0, 9, b"c1", b"coinone", b"first coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/01c8b1ae-0f08-41fe-a588-5c27204a850f.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

