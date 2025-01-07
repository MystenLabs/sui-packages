module 0xf2d338399355eca17bfc7acc5945a225e0d6af0d0fd297ffe3f1a6368263ddb1::meme_for_fun {
    struct MEME_FOR_FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_FOR_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_FOR_FUN>(arg0, 6, b"MEME_FOR_FUN", b"Meme For Fun", b"Not For Money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i0.wp.com/airdropalert.com/wp-content/uploads/2024/05/PEPE-meme-coin-ATH2.png?fit=1792%2C1024&ssl=1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_FOR_FUN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_FOR_FUN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_FOR_FUN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

