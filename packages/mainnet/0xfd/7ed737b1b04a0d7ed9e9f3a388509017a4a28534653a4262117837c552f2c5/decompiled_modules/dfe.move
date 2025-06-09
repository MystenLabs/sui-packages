module 0xfd7ed737b1b04a0d7ed9e9f3a388509017a4a28534653a4262117837c552f2c5::dfe {
    struct DFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFE>(arg0, 6, b"DFE", b"dfdf", b"SFDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid75ph2nxiwnffgrxhngu522fzf6ivtzrro5apchirkpwmjb3aqnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DFE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

