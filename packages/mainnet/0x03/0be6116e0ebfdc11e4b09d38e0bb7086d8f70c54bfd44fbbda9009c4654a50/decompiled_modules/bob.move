module 0x30be6116e0ebfdc11e4b09d38e0bb7086d8f70c54bfd44fbbda9009c4654a50::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", x"426f627a696c6c61f09fa696", b"Bobzillatoken Launching on Moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibpt6u7qvvg2wftmtjx7facchhzllqs5gyj34xr3x5odduwu5anii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

