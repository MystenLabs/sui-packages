module 0x72dd382d8fc2747d2a9984abd568487c4a90c1abaa8aa397dad9a7d27d56eae9::suicity {
    struct SUICITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICITY>(arg0, 6, b"SUICITY", b"Sui City", b"The first fully onchain Play2Airdrop game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_Ll_Ji_Yin_400x400_ace4937f84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

