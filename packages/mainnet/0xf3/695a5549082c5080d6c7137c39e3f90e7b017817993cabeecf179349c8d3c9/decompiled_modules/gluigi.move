module 0xf3695a5549082c5080d6c7137c39e3f90e7b017817993cabeecf179349c8d3c9::gluigi {
    struct GLUIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUIGI>(arg0, 9, b"GLUIGI", b"Luigi Giga Chad", b"The testosterone growth leads to muscle growth. Turning the nuts has become easier than ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9kYd8hu6Yh69K9Me2kyxtHsHhciP44kfNqRYBwhZpump.png?size=xl&key=adbf7f")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GLUIGI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLUIGI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUIGI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

