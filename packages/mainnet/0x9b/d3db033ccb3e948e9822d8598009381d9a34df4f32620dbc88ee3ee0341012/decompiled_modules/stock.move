module 0x9bd3db033ccb3e948e9822d8598009381d9a34df4f32620dbc88ee3ee0341012::stock {
    struct STOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOCK>(arg0, 6, b"STOCK", b"Digital Asset Stockpile", b"A cultural meme token inspired by Trumps National Digital Asset Stockpile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_062407_218_f7d6fb995e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

