module 0x8e537ed53969c4331a930d77dddae39987e1b35332a45d2655dbe7b4619d6319::gondola {
    struct GONDOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONDOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONDOLA>(arg0, 9, b"GONDOLA", b"Gondola", b"hodl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DG3LB7Kr8Londuz1j2us4YUXyNqiiLioKdYjSB37HbN2.png?size=xl&key=7ca9c3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GONDOLA>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONDOLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONDOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

