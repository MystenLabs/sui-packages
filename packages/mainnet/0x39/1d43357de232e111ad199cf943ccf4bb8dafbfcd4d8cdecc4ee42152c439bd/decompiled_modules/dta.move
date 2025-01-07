module 0x391d43357de232e111ad199cf943ccf4bb8dafbfcd4d8cdecc4ee42152c439bd::dta {
    struct DTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTA>(arg0, 6, b"DTA", b"Dog Theft Auto", b"DOG THEFT AUTO..... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047923_909cd96659.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

