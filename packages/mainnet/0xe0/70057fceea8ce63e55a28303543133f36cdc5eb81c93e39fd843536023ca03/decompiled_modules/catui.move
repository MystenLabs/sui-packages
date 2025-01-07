module 0xe070057fceea8ce63e55a28303543133f36cdc5eb81c93e39fd843536023ca03::catui {
    struct CATUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATUI>(arg0, 6, b"Catui", b"CATUI", b"Catui movepump cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SFSDFSDF_419c13dc04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

