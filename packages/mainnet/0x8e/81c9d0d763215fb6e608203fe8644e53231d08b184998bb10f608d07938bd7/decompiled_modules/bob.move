module 0x8e81c9d0d763215fb6e608203fe8644e53231d08b184998bb10f608d07938bd7::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"Bobzilla", x"4d7920667269656e64732063616c6c206d652024424f42200a42757420796f752063616e20612063616c6c206d652024426f627a696c6c61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiewgut3h6fvvnagtwelhqjvemwmmfblnpomcolzdjb7c3aqnnae6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

