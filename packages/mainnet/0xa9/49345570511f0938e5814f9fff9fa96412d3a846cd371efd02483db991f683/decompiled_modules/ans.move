module 0xa949345570511f0938e5814f9fff9fa96412d3a846cd371efd02483db991f683::ans {
    struct ANS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ANS>, arg1: 0x2::coin::Coin<ANS>) {
        0x2::coin::burn<ANS>(arg0, arg1);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<ANS>) : u64 {
        0x2::coin::total_supply<ANS>(arg0)
    }

    public fun balance(arg0: &0x2::coin::Coin<ANS>) : u64 {
        0x2::coin::value<ANS>(arg0)
    }

    fun init(arg0: ANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANS>(arg0, 9, b"ANS", b"Anas", b"First token created by me on dropkit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ahcofnfovqbxmroyxmuy.supabase.co/storage/v1/object/public/drop-images/1754316119265-n00rjif1i3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANS>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<ANS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

