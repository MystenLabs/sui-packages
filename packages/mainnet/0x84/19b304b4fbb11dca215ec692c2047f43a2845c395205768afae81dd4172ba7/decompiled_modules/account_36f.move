module 0x8419b304b4fbb11dca215ec692c2047f43a2845c395205768afae81dd4172ba7::account_36f {
    struct ACCOUNT_36F has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_36F>, arg1: 0x2::coin::Coin<ACCOUNT_36F>) {
        0x2::coin::burn<ACCOUNT_36F>(arg0, arg1);
    }

    fun init(arg0: ACCOUNT_36F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOUNT_36F>(arg0, 9, b"CETUS_R5314", b"Cetus (Reserve)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-Uz2ErmUtj1.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ACCOUNT_36F>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACCOUNT_36F>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_36F>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACCOUNT_36F> {
        0x2::coin::mint<ACCOUNT_36F>(arg0, arg1, arg2)
    }

    public entry fun supply_to(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_36F>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ACCOUNT_36F>>(0x2::coin::mint<ACCOUNT_36F>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

