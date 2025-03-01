module 0x881db24198bfe413008c1d27d572df242b912434f8a8d026445e13416aafff05::karen {
    struct KAREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAREN>(arg0, 9, b"KAREN", b"KarenCoin", b"A meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAREN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAREN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

