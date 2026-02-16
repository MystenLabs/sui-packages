module 0x5a917875480ae5b2a2689212713fe233bc69cd1f3ba9b8b1ce8bc8538f3cc780::vault_ac7 {
    struct VAULT_AC7 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT_AC7>, arg1: 0x2::coin::Coin<VAULT_AC7>) {
        0x2::coin::burn<VAULT_AC7>(arg0, arg1);
    }

    fun init(arg0: VAULT_AC7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT_AC7>(arg0, 9, b"veHAEDAL", b"Haedal Protocol", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-GvnSd7WSoh.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT_AC7>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT_AC7>>(v1);
    }

    public fun invoke(arg0: &mut 0x2::coin::TreasuryCap<VAULT_AC7>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT_AC7> {
        0x2::coin::mint<VAULT_AC7>(arg0, arg1, arg2)
    }

    public entry fun invoke_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT_AC7>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT_AC7>>(0x2::coin::mint<VAULT_AC7>(arg0, arg1, arg3), arg2);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

