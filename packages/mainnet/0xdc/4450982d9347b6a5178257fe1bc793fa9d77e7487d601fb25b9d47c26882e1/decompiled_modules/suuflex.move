module 0xdc4450982d9347b6a5178257fe1bc793fa9d77e7487d601fb25b9d47c26882e1::suuflex {
    struct SUUFLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUFLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUFLEX>(arg0, 6, b"SuuFlex", b"SUINAMI BEGINS", b"Not just another streaming platform. We make move's, we make waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsadsa_47779c4320.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUFLEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUFLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

