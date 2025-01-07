module 0xfa6988b47f16101b111f35cfd79a9cba0d8bdd5d94e66f89c912285265fab692::bitch {
    struct BITCH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITCH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BITCH>>(0x2::coin::mint<BITCH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCH>(arg0, 6, b"BITCH", b"BITCH", b"This is BITCH token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

