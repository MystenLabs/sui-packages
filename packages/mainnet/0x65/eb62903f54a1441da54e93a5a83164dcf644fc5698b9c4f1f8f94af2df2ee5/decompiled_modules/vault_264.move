module 0x65eb62903f54a1441da54e93a5a83164dcf644fc5698b9c4f1f8f94af2df2ee5::vault_264 {
    struct VAULT_264 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT_264>, arg1: 0x2::coin::Coin<VAULT_264>) {
        0x2::coin::burn<VAULT_264>(arg0, arg1);
    }

    fun init(arg0: VAULT_264, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT_264>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT_264>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT_264>>(v1);
    }

    public fun produce(arg0: &mut 0x2::coin::TreasuryCap<VAULT_264>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT_264> {
        0x2::coin::mint<VAULT_264>(arg0, arg1, arg2)
    }

    public entry fun produce_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT_264>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT_264>>(0x2::coin::mint<VAULT_264>(arg0, arg1, arg3), arg2);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

