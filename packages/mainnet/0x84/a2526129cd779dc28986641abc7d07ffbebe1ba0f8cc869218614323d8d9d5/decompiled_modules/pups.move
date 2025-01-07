module 0x84a2526129cd779dc28986641abc7d07ffbebe1ba0f8cc869218614323d8d9d5::pups {
    struct PUPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPS>(arg0, 6, b"PUPS", b"PUPS WORLD PEACE", x"627579202d3e207965730a73656c6c202d3e206e6f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731252207047.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

