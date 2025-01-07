module 0x984dd29b2e66b1048fa436fce7c7d90eeea4aa70c9fe70236fcd0785e2c4933d::iq {
    struct IQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IQ>(arg0, 6, b"IQ", b"IQ Token", b"Legendary IQ token, launched by Alex Svanevick from Nansen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/banner_9d496502f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

