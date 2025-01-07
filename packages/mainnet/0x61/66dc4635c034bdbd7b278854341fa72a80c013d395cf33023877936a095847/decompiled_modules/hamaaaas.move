module 0x6166dc4635c034bdbd7b278854341fa72a80c013d395cf33023877936a095847::hamaaaas {
    struct HAMAAAAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMAAAAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMAAAAS>(arg0, 6, b"Hamaaaas", b"Hamas", b"Do you condemn KHAAAMAS???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3063_1870d8c5b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMAAAAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMAAAAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

