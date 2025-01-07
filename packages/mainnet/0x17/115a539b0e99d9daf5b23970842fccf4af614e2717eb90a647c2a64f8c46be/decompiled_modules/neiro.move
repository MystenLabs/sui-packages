module 0x17115a539b0e99d9daf5b23970842fccf4af614e2717eb90a647c2a64f8c46be::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"Neiro on Sui", b"Inspired by the success of NEIRO on Ethereum, we're bringing this community-powered meme coin to the SUI blockchain. With no transaction taxes and a focus on community engagement, NEIRO on SUI aims to create a fun and engaging crypto experience. Join us as we grow the NEIRO community and explore the potential of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nieirosunlogomain_bdcae7b1f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

