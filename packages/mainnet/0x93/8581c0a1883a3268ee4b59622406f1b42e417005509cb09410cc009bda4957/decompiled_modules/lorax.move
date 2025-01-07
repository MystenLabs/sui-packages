module 0x938581c0a1883a3268ee4b59622406f1b42e417005509cb09410cc009bda4957::lorax {
    struct LORAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORAX>(arg0, 6, b"LORAX", b"Lorax ", b"Fair Launch! Open to the whole SUI community! Celebrate the Lorax!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734309548071.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LORAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

