module 0xc684a63779028041150e16474b7f126c655d4897162891e3afa2e4ff08d77424::fic {
    struct FIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIC>(arg0, 9, b"FIC", b"Fish in Condom", x"6669736820696e206120636f6e646f6d2e206e6f7468696e67206d6f72652c206e6f7468696e67206c6573732e2054484520434f4e444f4d2053544159204f4e2120f09f909ff09faa96", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4DEFCb5t4Ww2YScco6mUhQNCpkB76ps1ev8nbNfvpump.png?size=lg&key=57e0e5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIC>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

