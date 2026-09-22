module 0x5a0e00003ca029a44d49b3a5dff48dbc58288c1e3886c9932aab9931125ffcc2::hrdr {
    struct HRDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRDR>(arg0, 9, b"HRDR", b"Hog Radar", b"Hog Radar - radar for the hogs", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRDR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRDR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HRDR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HRDR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

