module 0xde8f7f43da5c53c26d7e36355709bed393a4590e2b475dfdae7899a21aabee72::catbome {
    struct CATBOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOME>(arg0, 6, b"CATBOME", b"CAT BOME", b"Missed $BOME??? Don't Miss $CATBOME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_c_1_cec78da5b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

