module 0xc530b33d4591ce4467e4832331c4561598d99b66df23a67e575a908c30b17045::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 6, b"GM", b"GM WORLD", b"GM WORLDD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib6sqoqs55km5woua3tuw6nbk6l6oioylluxfdbzcglbo7dciwsam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

