module 0xa7bd6ddb72cb5fb61e7cf3860b200dd78196279f99847b50f2a7f9b31fbfc010::fantasy_facuet_coin {
    struct FANTASY_FACUET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FANTASY_FACUET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FANTASY_FACUET_COIN>(arg0, 9, b"FANTASY_FACUET", b"FANTASY_FACUET", b"FANTASY's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/177515664")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FANTASY_FACUET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FANTASY_FACUET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FANTASY_FACUET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FANTASY_FACUET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

