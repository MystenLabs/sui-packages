module 0x165a8a636ad781363c998df06bc2c887193a7a2c428c1e97b944e81148772068::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 9, b"MYCOIN", b"MY COIN", b"One Test Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://4odpd2o2yyiplzw6rnulbrtbrirtkl73dfkxmueoldpyrhrrni2a.arweave.net/44bx6drGEPXm3otosMZhiiM1L_sZVXZQjljfiJ4xajQ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

