module 0x879770e4de378d91b25617d6b5e938f18987fe1d1fcc587f0025bdd6fb554f64::catimus {
    struct CATIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATIMUS>(arg0, 6, b"CATIMUS", b"catIMUS", b"Introducing Tesla CATYMUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010043_3995ff66f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

