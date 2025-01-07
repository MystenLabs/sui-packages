module 0x95d156c77abeda568ac0ccae754b98efeaf9561c3ff1fd93692391c57c451801::sueta {
    struct SUETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUETA>(arg0, 7, b"SUETA", b"Sui extreme trading anarchy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/EshwCHdXUAAs658.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUETA>(&mut v2, 17171717710000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUETA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

