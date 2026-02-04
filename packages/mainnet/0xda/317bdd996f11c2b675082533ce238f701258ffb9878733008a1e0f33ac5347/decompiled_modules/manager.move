module 0xda317bdd996f11c2b675082533ce238f701258ffb9878733008a1e0f33ac5347::manager {
    struct MANAGER has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MANAGER>, arg1: 0x2::coin::Coin<MANAGER>) {
        0x2::coin::burn<MANAGER>(arg0, arg1);
    }

    public fun handle(arg0: &mut 0x2::coin::TreasuryCap<MANAGER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MANAGER> {
        0x2::coin::mint<MANAGER>(arg0, arg1, arg2)
    }

    public entry fun handle_to(arg0: &mut 0x2::coin::TreasuryCap<MANAGER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MANAGER>>(0x2::coin::mint<MANAGER>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGER>(arg0, 9, b"NAVX_R8052", b"NAVX Token (Reserve)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-Sg_zHbCBP4.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MANAGER>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGER>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

