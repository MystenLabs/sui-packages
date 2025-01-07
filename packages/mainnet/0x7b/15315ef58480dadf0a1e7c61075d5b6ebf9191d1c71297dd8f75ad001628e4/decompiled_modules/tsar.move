module 0x7b15315ef58480dadf0a1e7c61075d5b6ebf9191d1c71297dd8f75ad001628e4::tsar {
    struct TSAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSAR>(arg0, 6, b"TSAR", b"Tsar Bomba", b"TSAR, an H-Bomb, and the most powerful nuclear weapon ever created and tested by humankind. Now as a MEME on the SUI blockchain.                                                                                                                                          ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TSAR_398389fb78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

