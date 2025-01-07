module 0x6fb1e939854f95591da531ff8797e6b256e22cc5f968a75925df5b53e7ba749c::dsdsds {
    struct DSDSDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSDSDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSDSDS>(arg0, 9, b"DSDSDS", b"SDSDSDS", b"DSDSDSDSDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d5a6681-c3ff-4f3c-adf6-75239fd653e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSDSDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSDSDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

