module 0x6789903bfba52469ecbbba90afe2c225ba7b07ecad4e668faf98538212d48140::testa {
    struct TESTA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTA>, arg1: 0x2::coin::Coin<TESTA>) {
        0x2::coin::burn<TESTA>(arg0, arg1);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<TESTA>) : u64 {
        0x2::coin::total_supply<TESTA>(arg0)
    }

    public fun balance(arg0: &0x2::coin::Coin<TESTA>) : u64 {
        0x2::coin::value<TESTA>(arg0)
    }

    fun init(arg0: TESTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTA>(arg0, 9, b"TESTA", b"test coin", b"asdfa sdfasfadsf dsaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ahcofnfovqbxmroyxmuy.supabase.co/storage/v1/object/public/drop-images/1753197786406-lqe8ji3ymm9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTA>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<TESTA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

