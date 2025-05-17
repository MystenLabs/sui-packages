module 0x95349adfba4e0420d536d39dce69f27775f1f3ac4967032e385c2bab18fff4a5::cattt {
    struct CATTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTT>(arg0, 9, b"catttt", b"cattt", b"catttcattt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

