module 0xf43eb940811d0edeefe2753c2e7f6b47fb6085d7c2ea8bce4d12e492a0a37cfb::godie {
    struct GODIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODIE>(arg0, 6, b"GoDie", b"FuckYou3c2029", b"Fucking little ferret sniper wallet on moonbags 3c2029", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidwmcoq435vejelupxhx5nmjwfo53a6pok5qrgcqfn4ersa4vjafe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GODIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

