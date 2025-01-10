module 0xfe278a4e5ea39f3973db5d3306a607fd938c0a8cea07e9f54a6602cc7f6ce4b0::suiwin {
    struct SUIWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIN>(arg0, 6, b"SUIWIN", b"SuiWin", b"Welcome To SUIWIN! Provably Fair Blockchain Gaming! |Coin Flip|FOMO|Dice|Blind Box|Blackjack|Teen patti|3 cards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6160_b1cc0c6122.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

