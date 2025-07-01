module 0x3b5377144db326e9928f2da05fc99ffded0c6b7aead024328fa8713582877063::outatime {
    struct OUTATIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: OUTATIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OUTATIME>(arg0, 6, b"OUTATIME", b"Outa Time", b"Just in time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidlg5j6mdb5sr7pazxnlvd6bnf4qqphisvrgm5dzk37et4bdv5ciu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OUTATIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OUTATIME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

