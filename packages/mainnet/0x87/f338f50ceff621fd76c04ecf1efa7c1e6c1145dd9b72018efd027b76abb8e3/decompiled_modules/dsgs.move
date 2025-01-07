module 0x87f338f50ceff621fd76c04ecf1efa7c1e6c1145dd9b72018efd027b76abb8e3::dsgs {
    struct DSGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSGS>(arg0, 9, b"DSGS", b"safsaf", b"GFRGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72534a6f-9a6e-4fc4-b114-9324a2217820.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

