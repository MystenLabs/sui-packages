module 0x2762e3f5565646cf5e4dda801e735d004fcd78fcd0c0db581716287523810365::solana {
    struct SOLANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLANA>(arg0, 6, b"SOLANA", b"Solana Pay", b"Solana Pay, an open, free-to-use payments framework built on Solana, is available to millions of businesses as an approved app integration on Shopify. Solana Pay is built for instant transactions and near-zero gas fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250202_165410_531_369ada5ab3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

