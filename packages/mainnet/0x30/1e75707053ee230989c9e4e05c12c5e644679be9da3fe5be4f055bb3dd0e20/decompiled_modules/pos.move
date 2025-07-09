module 0x301e75707053ee230989c9e4e05c12c5e644679be9da3fe5be4f055bb3dd0e20::pos {
    struct POS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POS>(arg0, 6, b"POS", b"POKEMONI  ON SUI", b"POS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih4maraz7f7ito2jsivuic5cnokvzkhdigmzeg73hqqjhqdxix3ce")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

