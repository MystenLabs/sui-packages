module 0xa370b879c17812d54e02c832d63b1c788ca515feecb95759d64f829f224a7c35::drippy {
    struct DRIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIPPY>(arg0, 6, b"Drippy", b"DripppppyDip", b"Drippppppppy Make Sui Wet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiam7kwnohbf76qaum4mfhvrzgdhp4znsom24d25sqyb3hy4t5tq3y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRIPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

