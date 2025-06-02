module 0x9b1e6343d632733c772c7e2b18fec0fcc0fe9ec9c58c13a0ecefe87fa3238b2e::team {
    struct TEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEAM>(arg0, 6, b"TEAM", b"Sui Pokemon Team", x"506f6bc3a96d6f6e20696e7370697265732066616e7320776f726c647769646520746f20656d6261726b206f6e206570696320616476656e74757265732c20636170747572696e67206865617274732077697468206974732076696272616e742063726561747572657320616e642074696d656c657373207468656d6573206f6620667269656e647368697020616e64207065727365766572616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia2trergrh7xed65j7ru6wunpf7jdrjlcmr6gnuu7pfx7faflffyy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

