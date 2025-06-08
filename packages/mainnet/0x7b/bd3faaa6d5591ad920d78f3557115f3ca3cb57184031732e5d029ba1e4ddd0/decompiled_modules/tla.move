module 0x7bbd3faaa6d5591ad920d78f3557115f3ca3cb57184031732e5d029ba1e4ddd0::tla {
    struct TLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLA>(arg0, 6, b"TLA", b"TEST LAUNCH", b"TEST LAUNCH don't buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieyssgyx53mwn5g7pxoqntosrerbqt6qrosos2jwyeqylbf377zmi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

