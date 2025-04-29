module 0x7c3355caf6c0ad704e5534b199525c201f2c60591a9928c3401c14e431dad6f::dogefather {
    struct DOGEFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEFATHER>(arg0, 9, b"DOGEFATHER", b"DOGEFATHER", b"https://x.com/cb_doge/status/1917048220095517170", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX5bbgkj3A3QTGb3FXRJRaeLQSWi2XbtK1tuEb7RLkLS5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGEFATHER>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEFATHER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEFATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

