module 0x1d6540e34844813bf368757db6a8bbf366ba716e059aecd360c5edc24acfd2aa::base_afc {
    struct BASE_AFC has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<BASE_AFC>, arg1: 0x2::coin::Coin<BASE_AFC>) {
        0x2::coin::burn<BASE_AFC>(arg0, arg1);
    }

    fun init(arg0: BASE_AFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASE_AFC>(arg0, 9, b"WWAL", b"Wrapped WAL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-tRUGk-pNA_.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BASE_AFC>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASE_AFC>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<BASE_AFC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BASE_AFC> {
        0x2::coin::mint<BASE_AFC>(arg0, arg1, arg2)
    }

    public entry fun supply_to(arg0: &mut 0x2::coin::TreasuryCap<BASE_AFC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASE_AFC>>(0x2::coin::mint<BASE_AFC>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

