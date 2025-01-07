module 0x4170e9834e32e3a3901b4cdf5814566d974101e594ea84e5f73e45bd2ff52c48::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORING>(arg0, 6, b"PORING", b"PoringSui", b"$PORING - The true meme token on $SUI blockchain with fair distribution on the Turbos platform on November 7 tg: https://t.me/PoringSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953265642.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

