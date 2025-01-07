module 0xda0979d18fb90b940c7617e869196a8e8f8c0d9dcbcc379b2ab6a1b04ac5bc0a::bert {
    struct BERT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BERT>, arg1: 0x2::coin::Coin<BERT>) {
        0x2::coin::burn<BERT>(arg0, arg1);
    }

    fun init(arg0: BERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BERT>(arg0, 9, b"BERT", b"Bertram The Pomeranian", b"Abandoned by breeders, adopted and crowned by the people of Solana.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HgBRWfYxEfvPhtqkaeymCQtHCrKE46qQ43pKe8HCpump.png?size=lg&key=2e6f18")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BERT>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BERT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BERT>>(v1, @0xb863324a5321cd326a84d69c8cc5917b43c2ee1a977ca209fd44997a5eeea220);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BERT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BERT>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BERT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BERT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

