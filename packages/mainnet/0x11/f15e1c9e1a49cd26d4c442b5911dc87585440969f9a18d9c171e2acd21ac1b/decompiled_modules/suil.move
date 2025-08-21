module 0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil {
    struct SUIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIL>(arg0, 9, b"SuiL", b"SuiL", b"The Sui Pro ecosystem is a decentralized liquidity pool and liquidity protocol on the Sui public chain, providing advanced trading and liquidity options. The Sui Pro ecosystem aims to build a robust and flexible liquidity network to enhance the trading experience and liquidity efficiency of DeFi users. Users can obtain SuiPro ecosystem tokens, SuiL, through ecosystem liquidity and Sui Bank, and holding these tokens can bring them greater benefits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipro.oss-cn-hongkong.aliyuncs.com/logo/suil.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIL>>(0x2::coin::from_balance<SUIL>(0x2::coin::mint_balance<SUIL>(&mut v2, 1000000000000000000), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

