module 0xd11c446ca93bc81edc6387d4f1cf81e28361f9d892a2b7898afd33721e1475a4::french {
    struct FRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENCH>(arg0, 6, b"FRENCH", b"Sui French", x"436f6d6d756e617574c3a9206672616ec3a761697365206465206c6120626c6f636b636861696e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiftkbnl5dnd7o7oxbyme4nxdemfv7crmwm6ufm74vvcvjgtrgrczu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRENCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

