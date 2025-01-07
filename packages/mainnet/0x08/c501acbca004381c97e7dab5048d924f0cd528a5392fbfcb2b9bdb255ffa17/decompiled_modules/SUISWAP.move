module 0x8c501acbca004381c97e7dab5048d924f0cd528a5392fbfcb2b9bdb255ffa17::SUISWAP {
    struct SUISWAP has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISWAP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISWAP>>(0x2::coin::mint<SUISWAP>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: SUISWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISWAP>(arg0, 9, b"SUISWAP", b"Suiswap", b"Swap platform on Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1649100092379480089/I8333KgA_400x400.jpg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISWAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISWAP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

