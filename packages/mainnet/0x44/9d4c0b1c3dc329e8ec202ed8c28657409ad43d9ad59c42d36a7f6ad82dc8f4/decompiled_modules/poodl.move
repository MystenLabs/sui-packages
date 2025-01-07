module 0x449d4c0b1c3dc329e8ec202ed8c28657409ad43d9ad59c42d36a7f6ad82dc8f4::poodl {
    struct POODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POODL>(arg0, 0, b"POODL", b"Poodl Inu", b"This is a SUI counterpart to Poodl Inu Ethereum ERC20 token 0x4b7c762af92dbd917d159eb282b85aa13e955739", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipns/k51qzi5uqu5djxcbj74bpaxbpjfpkrfudmmetsc3ypl8g5hs07npif9nbm2xhj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POODL>(&mut v2, 6900000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POODL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

