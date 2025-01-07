module 0xdc0467ce29dfe2d5e96fef1a4076b0fb8664ce216d1761ff008194f16d6b626d::aaacats {
    struct AAACATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACATS>(arg0, 9, b"aaaCats", b"aaaaCats", b"aaaaaaaaaaaaaaaaaCats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/QmaLhG2tRrYp7a9vML3uCDJZz9VeZ2y66unQnRsJUpeXpF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAACATS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAACATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

