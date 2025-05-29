module 0xe89b2898edb4f084b474a19cbb777426ad553595d42fa9124284107644263f41::sslow {
    struct SSLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSLOW>(arg0, 6, b"SSLOW", b"SlowSui", b"When Sui Network launched, Slowpoke asked in confusion: \"Am I too slow?\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidl3t4eqc22eykwtvx3x7mayd45avmp3p7edfuumfepc4o3f2ivaq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSLOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

