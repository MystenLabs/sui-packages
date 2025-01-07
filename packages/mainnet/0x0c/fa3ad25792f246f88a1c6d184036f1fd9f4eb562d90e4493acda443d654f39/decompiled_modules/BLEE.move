module 0xcfa3ad25792f246f88a1c6d184036f1fd9f4eb562d90e4493acda443d654f39::BLEE {
    struct BLEE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLEE>, arg1: 0x2::coin::Coin<BLEE>) {
        0x2::coin::burn<BLEE>(arg0, arg1);
    }

    fun init(arg0: BLEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEE>(arg0, 6, b"BLEE", b"BLEE COIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLEE>>(v1);
        0x2::coin::mint_and_transfer<BLEE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

