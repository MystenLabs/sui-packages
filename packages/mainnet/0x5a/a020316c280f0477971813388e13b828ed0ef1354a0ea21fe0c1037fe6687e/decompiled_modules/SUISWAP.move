module 0x5aa020316c280f0477971813388e13b828ed0ef1354a0ea21fe0c1037fe6687e::SUISWAP {
    struct SUISWAP has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISWAP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISWAP>>(0x2::coin::mint<SUISWAP>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: SUISWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISWAP>(arg0, 9, b"SSWP", b"Suiswap", b"Swap platform on Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1649781614577328130/ESy-Eujx_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISWAP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISWAP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISWAP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

