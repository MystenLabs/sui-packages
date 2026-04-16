module 0x320f71aa673c9790d86ae000d26fe6aa66b896a0e69561d33f6ceb75ce54e9e9::registry_c9e {
    struct REGISTRY_C9E has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY_C9E>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<REGISTRY_C9E> {
        0x2::coin::mint<REGISTRY_C9E>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY_C9E>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REGISTRY_C9E>>(0x2::coin::mint<REGISTRY_C9E>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY_C9E>, arg1: 0x2::coin::Coin<REGISTRY_C9E>) {
        0x2::coin::burn<REGISTRY_C9E>(arg0, arg1);
    }

    fun init(arg0: REGISTRY_C9E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGISTRY_C9E>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<REGISTRY_C9E>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGISTRY_C9E>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

