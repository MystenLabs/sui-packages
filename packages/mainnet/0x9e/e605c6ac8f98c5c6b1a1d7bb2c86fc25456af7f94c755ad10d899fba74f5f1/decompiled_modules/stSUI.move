module 0x9ee605c6ac8f98c5c6b1a1d7bb2c86fc25456af7f94c755ad10d899fba74f5f1::stSUI {
    struct STSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STSUI>(arg0, 9, b"stSUI", b"AlphaFi Staked SUI", b"Instantly unstakable liquid staking token by AlphaFi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.alphafi.xyz/stSUI.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STSUI>>(0x2::coin::mint<STSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STSUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

