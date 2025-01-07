module 0x6bd664b713a9db23a42c3da32a168179a565ea770688e58e2a40e807ceaebab9::aaat {
    struct AAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAT>(arg0, 6, b"AAAT", b"AAATRUMP ON SUI", b"$aaaTrump: The battle for control of the blockchain: A group of hackers is plotting to attack the Sui BlockChain and take over $aaaTrump . Can $aaaTrump and its community protect their virtual currency?. Telegram: https://t.me/aaatrump, Web: aaatrump.fun, X: https://x.com/aaatrump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_23_55_16_e5366e9df1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

