module 0x788572ddcede67ff7375dbe1502306c933ccf8341a36cc3ea83a5f2e00833fda::coin_z {
    struct COIN_Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_Z>(arg0, 9, b"CoinZ", b"CoinZ", b"Test coin Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COIN_Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

