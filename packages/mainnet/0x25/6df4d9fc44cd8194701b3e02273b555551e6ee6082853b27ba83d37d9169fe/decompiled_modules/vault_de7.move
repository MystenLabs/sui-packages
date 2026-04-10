module 0x256df4d9fc44cd8194701b3e02273b555551e6ee6082853b27ba83d37d9169fe::vault_de7 {
    struct VAULT_DE7 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT_DE7>, arg1: 0x2::coin::Coin<VAULT_DE7>) {
        0x2::coin::burn<VAULT_DE7>(arg0, arg1);
    }

    public fun distribute(arg0: &mut 0x2::coin::TreasuryCap<VAULT_DE7>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT_DE7> {
        0x2::coin::mint<VAULT_DE7>(arg0, arg1, arg2)
    }

    public entry fun distribute_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT_DE7>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT_DE7>>(0x2::coin::mint<VAULT_DE7>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VAULT_DE7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT_DE7>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT_DE7>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT_DE7>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

