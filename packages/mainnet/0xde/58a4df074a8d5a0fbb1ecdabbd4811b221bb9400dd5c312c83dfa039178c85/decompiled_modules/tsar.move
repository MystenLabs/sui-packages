module 0xde58a4df074a8d5a0fbb1ecdabbd4811b221bb9400dd5c312c83dfa039178c85::tsar {
    struct TSAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSAR>(arg0, 6, b"TSAR", b"T S A R", b"TSAR, the mother of all bombs is an H-Bomb, and the most powerful nuclear weapon ever created and tested by humankind. Now as a MEME on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOG_Ocopia_7ccec6b898.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

