module 0x9ae19a215b3ea2c95c8e3d56f51933de57f1d4a3f9a127f281a4439141ac2aff::lucky7suibuy {
    struct LUCKY7SUIBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY7SUIBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY7SUIBUY>(arg0, 6, b"Lucky7suibuy", b"Lucky 7 sui buy", x"57652062656c6965766520696e204c75636b79203720206a6f696e207573206f6e20200a4c75636b792037207375692062757920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000071734_6a182ad3b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY7SUIBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKY7SUIBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

