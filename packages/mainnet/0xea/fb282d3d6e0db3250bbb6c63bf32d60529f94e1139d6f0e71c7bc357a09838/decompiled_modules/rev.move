module 0xeafb282d3d6e0db3250bbb6c63bf32d60529f94e1139d6f0e71c7bc357a09838::rev {
    struct REV has drop {
        dummy_field: bool,
    }

    fun init(arg0: REV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REV>(arg0, 6, b"REV", b"REVELATION", b"ALL WILL BE REVEALED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiddpelttcymbqxc5hcmijotqk2vx4slfdmqps66fzpypseimhx77m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

