module 0x7b98012f4889a2f41489a15eea7f7f975691c7209e4ed4e203fedd015b4e7461::suidgame {
    struct SUIDGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDGAME>(arg0, 6, b"SUIDGAME", b"Suid Game CTO", x"526561647920746f2067657420696e207468652067616d653f20205468652067616d6520737461727473207269676874206e6f77210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b0b508378815c71llb4790ff4e6e5a8694_2_1_f6ee7560d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDGAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

