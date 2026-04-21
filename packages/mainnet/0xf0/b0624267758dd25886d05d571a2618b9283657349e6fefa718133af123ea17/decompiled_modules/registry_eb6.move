module 0xf0b0624267758dd25886d05d571a2618b9283657349e6fefa718133af123ea17::registry_eb6 {
    struct REGISTRY_EB6 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY_EB6>, arg1: 0x2::coin::Coin<REGISTRY_EB6>) {
        0x2::coin::burn<REGISTRY_EB6>(arg0, arg1);
    }

    fun init(arg0: REGISTRY_EB6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGISTRY_EB6>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<REGISTRY_EB6>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGISTRY_EB6>>(v1);
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY_EB6>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<REGISTRY_EB6> {
        0x2::coin::mint<REGISTRY_EB6>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY_EB6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REGISTRY_EB6>>(0x2::coin::mint<REGISTRY_EB6>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

