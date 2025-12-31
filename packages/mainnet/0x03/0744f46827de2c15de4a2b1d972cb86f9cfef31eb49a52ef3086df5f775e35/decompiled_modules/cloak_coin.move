module 0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::cloak_coin {
    struct CLOAK_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLOAK_COIN>, arg1: 0x2::coin::Coin<CLOAK_COIN>) {
        0x2::coin::burn<CLOAK_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLOAK_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<CLOAK_COIN>(arg0) + arg1 <= 1000000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<CLOAK_COIN>>(0x2::coin::mint<CLOAK_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CLOAK_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOAK_COIN>(arg0, 9, b"CLOAK", b"CloakPay Token", b"Utility token for CloakPay Relayer Network - Privacy-focused stealth payments on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://c1oak.xyz/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOAK_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOAK_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun max_supply() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

