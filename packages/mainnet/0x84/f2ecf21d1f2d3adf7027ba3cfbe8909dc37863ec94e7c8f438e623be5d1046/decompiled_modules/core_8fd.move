module 0x84f2ecf21d1f2d3adf7027ba3cfbe8909dc37863ec94e7c8f438e623be5d1046::core_8fd {
    struct CORE_8FD has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CORE_8FD>, arg1: 0x2::coin::Coin<CORE_8FD>) {
        0x2::coin::burn<CORE_8FD>(arg0, arg1);
    }

    fun init(arg0: CORE_8FD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE_8FD>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CORE_8FD>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE_8FD>>(v1);
    }

    public fun perform(arg0: &mut 0x2::coin::TreasuryCap<CORE_8FD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE_8FD> {
        0x2::coin::mint<CORE_8FD>(arg0, arg1, arg2)
    }

    public entry fun perform_to(arg0: &mut 0x2::coin::TreasuryCap<CORE_8FD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE_8FD>>(0x2::coin::mint<CORE_8FD>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

