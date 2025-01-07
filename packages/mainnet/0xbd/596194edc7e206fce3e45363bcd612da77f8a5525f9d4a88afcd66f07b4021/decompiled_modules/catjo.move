module 0xbd596194edc7e206fce3e45363bcd612da77f8a5525f9d4a88afcd66f07b4021::catjo {
    struct CATJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATJO>(arg0, 6, b"CATJO", b"Catjo", b"Yowaimweow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gajo_686382d386.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

