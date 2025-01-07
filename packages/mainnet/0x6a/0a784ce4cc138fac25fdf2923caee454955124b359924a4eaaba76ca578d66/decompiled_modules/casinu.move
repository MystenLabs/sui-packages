module 0x6a0a784ce4cc138fac25fdf2923caee454955124b359924a4eaaba76ca578d66::casinu {
    struct CASINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CASINU>, arg1: 0x2::coin::Coin<CASINU>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CASINU>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CASINU>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: CASINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASINU>(arg0, 6, b"CASINU SUI", b"CASINU", b"Casinu Inu - $CASINU. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-magnetic-ptarmigan-262.mypinata.cloud/ipfs/QmYwCte7D8MGxArcd5vas2T41yqsHFqr8D7xwj8ahiNc5m")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CASINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<CASINU>, arg1: 0x2::coin::Coin<CASINU>) : u64 {
        0x2::coin::burn<CASINU>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<CASINU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CASINU> {
        0x2::coin::mint<CASINU>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

