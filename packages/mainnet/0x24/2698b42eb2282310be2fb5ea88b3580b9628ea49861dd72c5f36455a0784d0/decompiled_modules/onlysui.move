module 0x242698b42eb2282310be2fb5ea88b3580b9628ea49861dd72c5f36455a0784d0::onlysui {
    struct ONLYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYSUI>(arg0, 6, b"ONLYSUI", b"Only Sui", b"Only sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifd5p5gdeipn5dss7svye6loj66qebvcyeqcezjgn3emvzcxtc6pu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONLYSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

