module 0xdb0a302d56a6d5450cf47d8ac2a546cb93cbf75c0ab2421ff6d07e688e6d5b2f::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"BOOK OF SUI", b"An experimental project poised to redefine web3 culture by amalgamating memes, decentralized storage solutions, and degen shitcoin trading and gambling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib7pzrqwjfqyeaaovfr55uzpmzw4aceixpju3hyqai4a4qnongwaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

