module 0xa68856dd7806847862b30429000a552c7437d1950538912186a39dc84acdf0ef::mmiu_coin {
    struct MMIU_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMIU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMIU_COIN>(arg0, 9, b"MMIU", b"MMiu Coin", b"MemMMiu Is a Good Coine shef year Of Shef is live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775866403935-e30a851647c19bba96fb73f9ce495188.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MMIU_COIN>>(0x2::coin::mint<MMIU_COIN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMIU_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMIU_COIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

