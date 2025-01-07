module 0xd6a90b067498c9e25248ef67a31021f90805db7df52db2664d53d3b9958a7a6e::mamba {
    struct MAMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMBA>(arg0, 6, b"MAMBA", b"Sui Mamba", b"just a snake mamba on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mamba_28614bc2f6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

