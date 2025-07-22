module 0x8cd68ecd61a5d50854cb6ce0f1e5aecc5f957d654202a6188654defcef35a5a9::stonz {
    struct STONZ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<STONZ>, arg1: 0x2::coin::Coin<STONZ>) {
        0x2::coin::burn<STONZ>(arg0, arg1);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<STONZ>) : u64 {
        0x2::coin::total_supply<STONZ>(arg0)
    }

    public fun balance(arg0: &0x2::coin::Coin<STONZ>) : u64 {
        0x2::coin::value<STONZ>(arg0)
    }

    fun init(arg0: STONZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONZ>(arg0, 9, b"STONZ", b"Stonz", x"546865204f6666696369616c2043757272656e6379206f662074686520476c6f62616c205354494b5a204d65746176657273650a2a4e6f742061637475616c6c7920612063757272656e63792e204d6574617665727365206e6f7420696e636c756465642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ahcofnfovqbxmroyxmuy.supabase.co/storage/v1/object/public/drop-images/1753200517000-tdcprvafno.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONZ>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STONZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<STONZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

