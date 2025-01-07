module 0x979b6bf2e42393a37955591c9bf0d34b1923311397dd06244cd0a82275ab91a6::my_faucet_token {
    struct MY_FAUCET_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_FAUCET_TOKEN>, arg1: 0x2::coin::Coin<MY_FAUCET_TOKEN>) {
        0x2::coin::burn<MY_FAUCET_TOKEN>(arg0, arg1);
    }

    public fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<MY_FAUCET_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_FAUCET_TOKEN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MY_FAUCET_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_FAUCET_TOKEN>(arg0, 6, b"NauxFaucet", b"Naux Faucet Coin", b"This is a faucet token issued by naux", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/13010589")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_FAUCET_TOKEN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MY_FAUCET_TOKEN>>(v0);
    }

    // decompiled from Move bytecode v6
}

