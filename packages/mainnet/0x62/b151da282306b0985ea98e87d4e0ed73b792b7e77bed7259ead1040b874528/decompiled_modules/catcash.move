module 0x62b151da282306b0985ea98e87d4e0ed73b792b7e77bed7259ead1040b874528::catcash {
    struct CATCASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCASH>(arg0, 6, b"CATCASH", b"CATCASH SUI", b"CATCASH MEME , GameFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731211039607.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCASH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCASH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

