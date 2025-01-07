module 0x2a62779b07b655def9bd1acfa03e47b476c09285ebf4210e5bf593e226394104::neo {
    struct NEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEO>(arg0, 6, b"NEO", b"NEO Calls", b"Test launch for those who have money in sui chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gmml_A_Or_400x400_db839e0377.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

