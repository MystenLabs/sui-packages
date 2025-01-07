module 0xb34ee5d71b828d857c52185491dd0fda3adb78bd7259432c602b19879a5be03e::dsgs {
    struct DSGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSGS>(arg0, 9, b"DSGS", b"safsaf", b"GFRGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8428ded2-0b31-4431-b27f-ea2c09cb35ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

