module 0xbc9db0dcbd5cfeb4ea94b50ee32b8ed8df7152d03be2bbda452df0eb8a109d30::yumi {
    struct YUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMI>(arg0, 9, b"yumi", b"New Doge", b"going viral on tiktok for doing the \"doge\" pose and is now being called the new doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FhbqJtDE5XXk9Netjvrx5nhmnXxFRAS9eoGLwMi2pump.png?size=xl&key=76fd28")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YUMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

