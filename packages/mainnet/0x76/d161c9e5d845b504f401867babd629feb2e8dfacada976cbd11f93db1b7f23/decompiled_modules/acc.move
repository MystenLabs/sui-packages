module 0x76d161c9e5d845b504f401867babd629feb2e8dfacada976cbd11f93db1b7f23::acc {
    struct ACC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACC>(arg0, 6, b"ACC", b"TRIANGLE ACC", b"TRIANGLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigm7psgrkkgzsytucnqwsip7ru3gewxkijhdf2wy6xkcjetibos6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ACC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

