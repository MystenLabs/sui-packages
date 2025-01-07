module 0x996d4f8374bb50970c1fa5cc10ca28374c00b2cd7f4a8e4d043981b4e839f0c8::dsgs {
    struct DSGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSGS>(arg0, 9, b"DSGS", b"safsaf", b"GFRGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8c4a9be-7142-4488-98c6-48a456eae7ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

