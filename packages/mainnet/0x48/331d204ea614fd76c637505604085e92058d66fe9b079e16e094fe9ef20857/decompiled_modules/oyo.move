module 0x48331d204ea614fd76c637505604085e92058d66fe9b079e16e094fe9ef20857::oyo {
    struct OYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OYO>(arg0, 6, b"OYO", b"OnYourOwn", x"596f7572206f776e20796f7572206f776e2c20492063726561746564207468697320746f6b656e2e20596f7572206f6e20796f7572206f776e20746f207368696c6c2c206372656174652074672c2063726561746520782e204465762068617320646f6e652074686520776f726b2e0a0a427579206120626167206f6e20796f7572206f776e20616e64207368696c6c20796f7572206f776e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034973_ad6742b4af.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

