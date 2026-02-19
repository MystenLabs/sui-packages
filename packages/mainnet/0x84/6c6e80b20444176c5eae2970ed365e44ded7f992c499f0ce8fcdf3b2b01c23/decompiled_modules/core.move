module 0x846c6e80b20444176c5eae2970ed365e44ded7f992c499f0ce8fcdf3b2b01c23::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: 0x2::coin::Coin<CORE>) {
        0x2::coin::burn<CORE>(arg0, arg1);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-RaFVykz9lG.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CORE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE>>(v1);
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE> {
        0x2::coin::mint<CORE>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE>>(0x2::coin::mint<CORE>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

