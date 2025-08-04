module 0xcd64e566103149ff0b9136b11334e4d863e3a9acfcb9fe94ed2232e3730b5c8b::catnip {
    struct CATNIP has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CATNIP>, arg1: 0x2::coin::Coin<CATNIP>) {
        0x2::coin::burn<CATNIP>(arg0, arg1);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<CATNIP>) : u64 {
        0x2::coin::total_supply<CATNIP>(arg0)
    }

    public fun balance(arg0: &0x2::coin::Coin<CATNIP>) : u64 {
        0x2::coin::value<CATNIP>(arg0)
    }

    fun init(arg0: CATNIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATNIP>(arg0, 9, b"CATNIP", b"ChillCat", b"Just a ChillCat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ahcofnfovqbxmroyxmuy.supabase.co/storage/v1/object/public/drop-images/1754317284367-l77kx9zfxpo.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATNIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATNIP>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATNIP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<CATNIP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

