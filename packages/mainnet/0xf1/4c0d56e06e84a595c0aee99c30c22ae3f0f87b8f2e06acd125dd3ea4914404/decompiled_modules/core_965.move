module 0xf14c0d56e06e84a595c0aee99c30c22ae3f0f87b8f2e06acd125dd3ea4914404::core_965 {
    struct CORE_965 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CORE_965>, arg1: 0x2::coin::Coin<CORE_965>) {
        0x2::coin::burn<CORE_965>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<CORE_965>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE_965> {
        0x2::coin::mint<CORE_965>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<CORE_965>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE_965>>(0x2::coin::mint<CORE_965>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CORE_965, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE_965>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CORE_965>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE_965>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

