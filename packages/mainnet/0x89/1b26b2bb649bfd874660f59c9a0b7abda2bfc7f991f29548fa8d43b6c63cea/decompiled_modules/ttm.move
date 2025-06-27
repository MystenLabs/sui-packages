module 0x891b26b2bb649bfd874660f59c9a0b7abda2bfc7f991f29548fa8d43b6c63cea::ttm {
    struct TTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTM>(arg0, 6, b"TTM", b"Titanium", b"Titanium is a chemical element with the symbol Ti and atomic number 22. It is a lustrous transition metal with a silver color, known for its low density and high strength, as well as its excellent corrosion resistance. It is a versatile metal used in various applications, including aerospace, marine, and biomedical fields", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaehui3sgcefaovvvbhxulws7xx4ztof2yyv54l5lfji7eatovrz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

