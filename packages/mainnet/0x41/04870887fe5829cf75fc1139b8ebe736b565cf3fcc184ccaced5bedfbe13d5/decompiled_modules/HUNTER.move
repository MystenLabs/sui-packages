module 0x4104870887fe5829cf75fc1139b8ebe736b565cf3fcc184ccaced5bedfbe13d5::HUNTER {
    struct HUNTER has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HUNTER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HUNTER>>(0x2::coin::mint<HUNTER>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: HUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNTER>(arg0, 9, b"HUNTER", b"HUNTER", b"Website: https://hunter-coin.xyz | First meme coin of Truth Socialist which made by Donald Trump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://hunter-coin.xyz/_next/image?url=%2Fassets%2Fimages%2Flogo.jpg&w=256&q=75"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUNTER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNTER>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HUNTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

