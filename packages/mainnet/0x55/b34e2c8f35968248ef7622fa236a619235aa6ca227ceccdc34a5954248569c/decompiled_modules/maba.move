module 0x55b34e2c8f35968248ef7622fa236a619235aa6ca227ceccdc34a5954248569c::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MABA>, arg1: 0x2::coin::Coin<MABA>) {
        0x2::coin::burn<MABA>(arg0, arg1);
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABA>(arg0, 9, b"MABA", b"Make America Based Again", b"Make America Based Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPyCcC9LxxyNHUtopjHBGDQRLP5NVtxWisR9ep9nyjAgc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MABA>(&mut v2, 80000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MABA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MABA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MABA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

