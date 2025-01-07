module 0x7ce6a6c4bac41fedb952e93aff8d0f8d6e92eeafee92dd3a189c4fc28bb641ca::blockchain {
    struct BLOCKCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOCKCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOCKCHAIN>(arg0, 6, b"BLOCKCHAIN", b"Block Chain", x"57652061726520616c6c20636f6e6e6563746564207468726f75676820424c4f434b434841494e0a43616e20796f75206665656c2069743f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ggk_X8_Pp_WUA_Aw_CVC_cffdae079a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOCKCHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOCKCHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

