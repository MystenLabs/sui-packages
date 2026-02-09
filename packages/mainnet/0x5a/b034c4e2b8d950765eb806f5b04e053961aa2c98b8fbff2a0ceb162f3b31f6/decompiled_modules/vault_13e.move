module 0x5ab034c4e2b8d950765eb806f5b04e053961aa2c98b8fbff2a0ceb162f3b31f6::vault_13e {
    struct VAULT_13E has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT_13E>, arg1: 0x2::coin::Coin<VAULT_13E>) {
        0x2::coin::burn<VAULT_13E>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<VAULT_13E>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT_13E> {
        0x2::coin::mint<VAULT_13E>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT_13E>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT_13E>>(0x2::coin::mint<VAULT_13E>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VAULT_13E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT_13E>(arg0, 9, b"GGD", b"GGD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-V8rXOk54wd.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT_13E>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT_13E>>(v1);
    }

    // decompiled from Move bytecode v6
}

