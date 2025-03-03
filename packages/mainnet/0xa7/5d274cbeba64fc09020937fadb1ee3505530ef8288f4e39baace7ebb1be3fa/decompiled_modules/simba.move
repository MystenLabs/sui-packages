module 0xa75d274cbeba64fc09020937fadb1ee3505530ef8288f4e39baace7ebb1be3fa::simba {
    struct SIMBA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIMBA>, arg1: 0x2::coin::Coin<SIMBA>) {
        0x2::coin::burn<SIMBA>(arg0, arg1);
    }

    fun init(arg0: SIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBA>(arg0, 10, b"SIM", b"SIMBA", b"my SIMBA coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIMBA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

