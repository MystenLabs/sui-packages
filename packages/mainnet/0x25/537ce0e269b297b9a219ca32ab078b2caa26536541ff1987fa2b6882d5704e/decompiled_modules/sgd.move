module 0x25537ce0e269b297b9a219ca32ab078b2caa26536541ff1987fa2b6882d5704e::sgd {
    struct SGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGD>(arg0, 6, b"SGD", b"SuiGold", b"pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/63d00249c1818f001b97c9b7cc498326_125315a8cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

