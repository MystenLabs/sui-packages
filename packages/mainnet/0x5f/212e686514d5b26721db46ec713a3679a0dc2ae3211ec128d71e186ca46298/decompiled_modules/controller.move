module 0x5f212e686514d5b26721db46ec713a3679a0dc2ae3211ec128d71e186ca46298::controller {
    struct CONTROLLER has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: 0x2::coin::Coin<CONTROLLER>) {
        0x2::coin::burn<CONTROLLER>(arg0, arg1);
    }

    fun init(arg0: CONTROLLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONTROLLER>(arg0, 9, b"cUSD", b"Wrapped cUSD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-h8m3_QSCmx.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CONTROLLER>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONTROLLER>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CONTROLLER> {
        0x2::coin::mint<CONTROLLER>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER>>(0x2::coin::mint<CONTROLLER>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

