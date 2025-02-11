module 0x14b39e1d5e373e278467d3d2005f702d888c13770adb64617b17ce33efca5b3c::stSUI {
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

