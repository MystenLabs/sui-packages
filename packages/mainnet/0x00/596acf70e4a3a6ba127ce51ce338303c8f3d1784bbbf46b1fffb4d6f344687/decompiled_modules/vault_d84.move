module 0x596acf70e4a3a6ba127ce51ce338303c8f3d1784bbbf46b1fffb4d6f344687::vault_d84 {
    struct VAULT_D84 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT_D84>, arg1: 0x2::coin::Coin<VAULT_D84>) {
        0x2::coin::burn<VAULT_D84>(arg0, arg1);
    }

    fun init(arg0: VAULT_D84, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT_D84>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT_D84>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT_D84>>(v1);
    }

    public fun produce(arg0: &mut 0x2::coin::TreasuryCap<VAULT_D84>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT_D84> {
        0x2::coin::mint<VAULT_D84>(arg0, arg1, arg2)
    }

    public entry fun produce_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT_D84>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT_D84>>(0x2::coin::mint<VAULT_D84>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

