module 0x1d14f7486d5d4f6a81449bf4e0622a6188e91b26a3d78bb0325d944b3d3dddea::vault_06f {
    struct VAULT_06F has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT_06F>, arg1: 0x2::coin::Coin<VAULT_06F>) {
        0x2::coin::burn<VAULT_06F>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<VAULT_06F>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT_06F> {
        0x2::coin::mint<VAULT_06F>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT_06F>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT_06F>>(0x2::coin::mint<VAULT_06F>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VAULT_06F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT_06F>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT_06F>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT_06F>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

