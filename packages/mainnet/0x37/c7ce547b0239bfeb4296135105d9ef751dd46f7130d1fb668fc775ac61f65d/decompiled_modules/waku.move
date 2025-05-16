module 0x37c7ce547b0239bfeb4296135105d9ef751dd46f7130d1fb668fc775ac61f65d::waku {
    struct WAKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAKU>(arg0, 6, b"WAKU", b"WAKU SUI", b"Waku a little dragon with big energy, ready to take over the SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic6ehskwiv7fhnwp63fdwifi6qirh4mw7voucohoifvwpdjldyzdm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAKU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

