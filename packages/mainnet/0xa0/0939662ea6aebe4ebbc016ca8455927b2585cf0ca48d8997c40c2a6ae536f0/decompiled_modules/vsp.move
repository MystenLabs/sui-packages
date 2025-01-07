module 0xa00939662ea6aebe4ebbc016ca8455927b2585cf0ca48d8997c40c2a6ae536f0::vsp {
    struct VSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSP>(arg0, 6, b"VSP", b"Vespa", b"Is an Italian brand of scooters and mopeds manufactured by Piaggio. The name means wasp in Italian. The Vespa has evolved from a single model motor scooter manufactured in 1946 by Piaggio & Co. S.p.A. of Ponteder", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732089050676.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

