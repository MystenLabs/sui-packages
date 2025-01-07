module 0x8816eaa7e3c9c46f7960c5ca8cd07d2804ccf97cfa9bbe87f33476a49ecf1bca::catos {
    struct CATOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATOS>(arg0, 6, b"CATOS", b"CATONYMOUS", b"Cat, Catho & Anonymous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4032_458cc3215a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

