module 0x938c3e4e43f563b07e6a4ab57ea9aa76e98999610fe34a1e5ed5ff83f6083aee::treasury_9bb {
    struct TREASURY_9BB has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_9BB>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TREASURY_9BB> {
        0x2::coin::mint<TREASURY_9BB>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_9BB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY_9BB>>(0x2::coin::mint<TREASURY_9BB>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_9BB>, arg1: 0x2::coin::Coin<TREASURY_9BB>) {
        0x2::coin::burn<TREASURY_9BB>(arg0, arg1);
    }

    fun init(arg0: TREASURY_9BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY_9BB>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREASURY_9BB>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY_9BB>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

