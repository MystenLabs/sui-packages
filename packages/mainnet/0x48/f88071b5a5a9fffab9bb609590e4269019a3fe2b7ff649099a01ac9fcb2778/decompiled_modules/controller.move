module 0x48f88071b5a5a9fffab9bb609590e4269019a3fe2b7ff649099a01ac9fcb2778::controller {
    struct CONTROLLER has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: 0x2::coin::Coin<CONTROLLER>) {
        0x2::coin::burn<CONTROLLER>(arg0, arg1);
    }

    fun init(arg0: CONTROLLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONTROLLER>(arg0, 9, b"GSUI", b"Grayscale Sui Staking ETF", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-RjiFdiTYW4.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CONTROLLER>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONTROLLER>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun perform(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CONTROLLER> {
        0x2::coin::mint<CONTROLLER>(arg0, arg1, arg2)
    }

    public entry fun perform_to(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER>>(0x2::coin::mint<CONTROLLER>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

