module 0xb09a7d960e811b57f91e1222eba51a206b16b93ca20750c9a0950e85292be0b2::billa_github2016_coin {
    struct BILLA_GITHUB2016_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLA_GITHUB2016_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLA_GITHUB2016_COIN>(arg0, 9, b"BG", b"BILLA_GITHUB2016_COIN", b"this is a coin minted by billa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/9780825?v=4"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLA_GITHUB2016_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLA_GITHUB2016_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BILLA_GITHUB2016_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BILLA_GITHUB2016_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

