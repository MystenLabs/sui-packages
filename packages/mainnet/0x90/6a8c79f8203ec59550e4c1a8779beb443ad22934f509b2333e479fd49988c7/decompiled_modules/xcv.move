module 0x906a8c79f8203ec59550e4c1a8779beb443ad22934f509b2333e479fd49988c7::xcv {
    struct XCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCV>(arg0, 6, b"XCV", b"sdxc", b"asdasdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib6sqoqs55km5woua3tuw6nbk6l6oioylluxfdbzcglbo7dciwsam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XCV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

