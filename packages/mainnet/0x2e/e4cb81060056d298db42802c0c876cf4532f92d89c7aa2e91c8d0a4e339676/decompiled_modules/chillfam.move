module 0x2ee4cb81060056d298db42802c0c876cf4532f92d89c7aa2e91c8d0a4e339676::chillfam {
    struct CHILLFAM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHILLFAM>, arg1: 0x2::coin::Coin<CHILLFAM>) {
        0x2::coin::burn<CHILLFAM>(arg0, arg1);
    }

    fun init(arg0: CHILLFAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLFAM>(arg0, 9, b"CHILLFAM", b"Chill Family", x"5765e280997265206e6f742072756e6e696e672074686520776f726c642c207765e280997265207374726f6c6c696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CSr7HhUyBxatPMuTqAs3Z33fwQ4dx8cNAArMert1pump.png?size=xl&key=d7ba30")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLFAM>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLFAM>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLFAM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLFAM>>(v1, @0xa4d70a13c2d9f6f262cd24854b122ed4f2a18d33c6856186ba01c4d993a973ce);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLFAM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLFAM>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHILLFAM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHILLFAM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

