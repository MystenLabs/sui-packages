module 0xa0223bd33d064b449290c169229a8ed04151a834c902cfa98088dbc716ea1c0c::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 9, b"DIDDY", b"The Official Diddy Meme", b"$DIDDY isn't just a meme coin-it's a decentralized rally cry.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CCAGrGiB4924TFQ5MGNAW9oQK7eZ9LmrwjRFoV5Lis2u.png?size=xl&key=be26cd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIDDY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

