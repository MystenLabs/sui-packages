module 0xf5107741e0b6e2a356b3b01479620bdc7d24693a01dc632601296cd18d740bfa::core_226 {
    struct CORE_226 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CORE_226>, arg1: 0x2::coin::Coin<CORE_226>) {
        0x2::coin::burn<CORE_226>(arg0, arg1);
    }

    public fun handle(arg0: &mut 0x2::coin::TreasuryCap<CORE_226>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE_226> {
        0x2::coin::mint<CORE_226>(arg0, arg1, arg2)
    }

    public entry fun handle_to(arg0: &mut 0x2::coin::TreasuryCap<CORE_226>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE_226>>(0x2::coin::mint<CORE_226>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CORE_226, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE_226>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CORE_226>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE_226>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

