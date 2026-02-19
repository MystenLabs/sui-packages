module 0x445d31ff07595e25440da3bddf196f82e0cfc4353406947aa15a79c70b1cb211::vault_36e {
    struct VAULT_36E has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<VAULT_36E>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT_36E> {
        0x2::coin::mint<VAULT_36E>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT_36E>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT_36E>>(0x2::coin::mint<VAULT_36E>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT_36E>, arg1: 0x2::coin::Coin<VAULT_36E>) {
        0x2::coin::burn<VAULT_36E>(arg0, arg1);
    }

    fun init(arg0: VAULT_36E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT_36E>(arg0, 9, b"WWAL", b"Wrapped WAL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-tRUGk-pNA_.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT_36E>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT_36E>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

