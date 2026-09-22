module 0x24fe7d8b11771de30793d48e53799c6ba42ee520ce52e236653d9fca9a71edbc::sead {
    struct SEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAD>(arg0, 9, b"SEAD", b"Seal Drop", b"Seal Drop is a community-led meme token channeling doge energy for Telegram drops, tipping, and quick raids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmNbLTyvrUiTdXVb9xjQkKEr3dsGL6U5v4SQJ65NeFtyYN")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SEAD>>(0x2::coin::mint<SEAD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

