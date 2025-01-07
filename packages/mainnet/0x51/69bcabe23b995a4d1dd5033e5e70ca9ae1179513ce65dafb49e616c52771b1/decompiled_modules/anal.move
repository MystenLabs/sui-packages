module 0x5169bcabe23b995a4d1dd5033e5e70ca9ae1179513ce65dafb49e616c52771b1::anal {
    struct ANAL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ANAL>, arg1: 0x2::coin::Coin<ANAL>) {
        0x2::coin::burn<ANAL>(arg0, arg1);
    }

    fun init(arg0: ANAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ANAL>(arg0, 9, b"ANAL", b"We Love Anal", b"We love them all, do we?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BfuPnXM7Qs46ZLuptSAHhmnoZ7sa8cpnfJnhTj81fKTg.png?size=xl&key=9d5a3f")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ANAL>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANAL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ANAL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ANAL>>(v1, @0x5cdec1b315c36449b6e3895120db92ac5fc89ac4781027b3c5ad668b38cf36e4);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ANAL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ANAL>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANAL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

