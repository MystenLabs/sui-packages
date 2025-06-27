module 0x9596802612d65544ed8ddc229dc5717e2868c0326aeac2085dd7be425cd0fd61::ttm {
    struct TTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTM>(arg0, 6, b"TTM", b"Titanium", b"Titanium is a strong, lustrous, and corrosion-resistant transition metal with the symbol Ti and atomic number 22. It is known for its high strength-to-weight ratio and is widely used in various applications due to its unique properties.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaehui3sgcefaovvvbhxulws7xx4ztof2yyv54l5lfji7eatovrz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

