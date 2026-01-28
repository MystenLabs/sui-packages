module 0xcfb4f44e7a8aad33eaa0e11e00a81ace1783d989f1fed7f4a5a302ccbe9f2d52::hhasui {
    struct HHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHASUI>(arg0, 9, b"hhasui", b"hhasui Coin", b"hhasui Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-testnet.haedal.xyz/htoken/hhasui.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

