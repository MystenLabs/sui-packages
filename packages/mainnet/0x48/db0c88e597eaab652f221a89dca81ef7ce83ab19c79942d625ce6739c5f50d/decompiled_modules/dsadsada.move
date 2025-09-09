module 0x48db0c88e597eaab652f221a89dca81ef7ce83ab19c79942d625ce6739c5f50d::dsadsada {
    struct DSADSADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSADSADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSADSADA>(arg0, 9, b"dsadsada", b"dsdsa", b"sadadasdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DSADSADA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSADSADA>>(v2, @0x3e8f93a16c31a79d450ba96c9ae494a8940b718125ad00b1361d35954c1e1670);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSADSADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

