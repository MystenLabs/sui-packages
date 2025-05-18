module 0x6b4855be346da76a437b51df0034bcebc8909b04860f51876543fe3d2978bf6b::suiape {
    struct SUIAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPE>(arg0, 6, b"SUIAPE", b"Sui Ape", x"5768617473206120636861696e20776974686f757420697473206f776e206170652057657265206865726520746f2066697820746861742e0a5468652061706520697320636f6d696e6720736f6f6e20746f20746865202453554920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmfg5wvlhe44indydjwxqmcb3n75ffas42nymgdb7gauuqexpgpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

