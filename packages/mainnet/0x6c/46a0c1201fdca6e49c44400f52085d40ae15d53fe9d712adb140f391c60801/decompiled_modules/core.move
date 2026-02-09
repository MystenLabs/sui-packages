module 0x6c46a0c1201fdca6e49c44400f52085d40ae15d53fe9d712adb140f391c60801::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: 0x2::coin::Coin<CORE>) {
        0x2::coin::burn<CORE>(arg0, arg1);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 9, b"SUI", b"Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-Wrxk4a_-BM.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CORE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE> {
        0x2::coin::mint<CORE>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE>>(0x2::coin::mint<CORE>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

