module 0xca616c14efb411f6431eb6efa7caa3ca3fc4c5bacbaa21fe0b4f6b519dd2fc20::qinglinquant {
    struct QINGLINQUANT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<QINGLINQUANT>, arg1: 0x2::coin::Coin<QINGLINQUANT>) {
        0x2::coin::burn<QINGLINQUANT>(arg0, arg1);
    }

    fun init(arg0: QINGLINQUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QINGLINQUANT>(arg0, 6, b"QING", b"QingLin_Quant", b"Quantitative Trading Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1820369543908188160/i5X6Z0ib_400x400.jpg#1770274688346566000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QINGLINQUANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QINGLINQUANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<QINGLINQUANT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QINGLINQUANT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

