module 0x5dc04b8faa9907c8eb0cf16af3dad40a1790159bb260d8c5d1363cdcd53cf1ec::tino {
    struct TINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINO>(arg0, 9, b"TINO", b"Quentin Tarantino", b"Quentin Jerome Tarantino is an American filmmaker, actor, and author. His films are characterized by stylized violence, extended dialogue often featuring much profanity, and references to popular culture. His work has earned a cult following alongside critical and commercial success; he has been named by some as the single most influential director of his generation and has received numerous awards and nominations, including two Academy Awards, two BAFTA Awards, and four Golden Globe Awards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/0/0b/Quentin_Tarantino_by_Gage_Skidmore.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TINO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINO>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

