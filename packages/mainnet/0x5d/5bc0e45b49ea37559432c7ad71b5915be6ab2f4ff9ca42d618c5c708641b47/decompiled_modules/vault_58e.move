module 0x5d5bc0e45b49ea37559432c7ad71b5915be6ab2f4ff9ca42d618c5c708641b47::vault_58e {
    struct VAULT_58E has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT_58E>, arg1: 0x2::coin::Coin<VAULT_58E>) {
        0x2::coin::burn<VAULT_58E>(arg0, arg1);
    }

    fun init(arg0: VAULT_58E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT_58E>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT_58E>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT_58E>>(v1);
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<VAULT_58E>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT_58E> {
        0x2::coin::mint<VAULT_58E>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT_58E>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT_58E>>(0x2::coin::mint<VAULT_58E>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

