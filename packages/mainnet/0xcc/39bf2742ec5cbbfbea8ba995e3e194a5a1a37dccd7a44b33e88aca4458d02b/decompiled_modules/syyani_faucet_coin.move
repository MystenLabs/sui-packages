module 0xcc39bf2742ec5cbbfbea8ba995e3e194a5a1a37dccd7a44b33e88aca4458d02b::syyani_faucet_coin {
    struct SYYANI_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SYYANI_FAUCET_COIN>, arg1: 0x2::coin::Coin<SYYANI_FAUCET_COIN>) {
        0x2::coin::burn<SYYANI_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: SYYANI_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYYANI_FAUCET_COIN>(arg0, 9, b"SYYANI_FAUCET", b"SYYANI_FAUCET", b"SYYANI faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/40732861")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYYANI_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SYYANI_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SYYANI_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SYYANI_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

