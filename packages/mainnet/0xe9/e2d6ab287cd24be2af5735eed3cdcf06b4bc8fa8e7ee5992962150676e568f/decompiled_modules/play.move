module 0xe9e2d6ab287cd24be2af5735eed3cdcf06b4bc8fa8e7ee5992962150676e568f::play {
    struct PLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAY>(arg0, 9, b"0X1", b"SuiPlay0X1 Gaming", b"0X1 - Utility Token used in SuiPlay0X1 is the first handheld gaming console of its kind. It supports a wide range of PC games, as well as new AAA games developed using Sui technology. Pre-order SuiPlay0X1 and receive 0X1 Token airdrop - suiplay0x1.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1816566699619155972/0Ho-Krf7_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PLAY>>(0x2::coin::mint<PLAY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PLAY>>(v2);
    }

    // decompiled from Move bytecode v6
}

