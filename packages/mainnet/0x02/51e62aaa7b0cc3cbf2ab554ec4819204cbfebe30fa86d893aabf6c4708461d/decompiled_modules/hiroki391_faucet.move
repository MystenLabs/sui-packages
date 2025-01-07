module 0x251e62aaa7b0cc3cbf2ab554ec4819204cbfebe30fa86d893aabf6c4708461d::hiroki391_faucet {
    struct HIROKI391_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HIROKI391_FAUCET>, arg1: 0x2::coin::Coin<HIROKI391_FAUCET>) {
        0x2::coin::burn<HIROKI391_FAUCET>(arg0, arg1);
    }

    fun init(arg0: HIROKI391_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIROKI391_FAUCET>(arg0, 9, b"HIROKI391_FAUCET", b"HIROKI391_FAUCET", b"Hiroki's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/165958351?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIROKI391_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HIROKI391_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HIROKI391_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HIROKI391_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

