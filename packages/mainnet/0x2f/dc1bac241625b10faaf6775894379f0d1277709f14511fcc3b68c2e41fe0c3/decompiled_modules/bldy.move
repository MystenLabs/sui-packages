module 0x2fdc1bac241625b10faaf6775894379f0d1277709f14511fcc3b68c2e41fe0c3::bldy {
    struct BLDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLDY>(arg0, 6, b"BLDY", b"BALDY", b"Onboard the masses ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_5d4b3f478e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

