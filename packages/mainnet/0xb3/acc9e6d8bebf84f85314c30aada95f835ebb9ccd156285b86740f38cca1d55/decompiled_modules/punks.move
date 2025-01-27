module 0xb3acc9e6d8bebf84f85314c30aada95f835ebb9ccd156285b86740f38cca1d55::punks {
    struct PUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKS>(arg0, 9, b"Punks", b"CryptoPunks", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmds4HefHRBjk4c89k6GHErjTCHbdYd2SLAmNEraotnGhG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUNKS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

