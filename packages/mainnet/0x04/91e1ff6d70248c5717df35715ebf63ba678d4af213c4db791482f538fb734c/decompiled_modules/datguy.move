module 0x491e1ff6d70248c5717df35715ebf63ba678d4af213c4db791482f538fb734c::datguy {
    struct DATGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DATGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DATGUY>(arg0, 9, b"DATGUY", b"Just Dat Guy", b"Just Dat Guy token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreidho7nz2ig52qshqvafblfg6meq7i7afjh3b26w6xhe2gycbexqwi.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DATGUY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DATGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DATGUY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

