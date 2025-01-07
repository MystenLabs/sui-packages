module 0x7214877b731309c12e33287266acda374f23d53c84f3bad931810f799ec1fd2::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 6, b"STONKS", b"Stonkseth", b"Stonks is an intentional misspelling of the word \"stocks\" often associated with a surreal meme featuring Meme Man standing in front of a stock market image with the caption \"Stonks.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STONKS_6f051ef4c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

