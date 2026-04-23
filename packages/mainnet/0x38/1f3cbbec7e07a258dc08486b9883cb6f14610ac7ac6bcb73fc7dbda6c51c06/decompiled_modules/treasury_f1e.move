module 0x381f3cbbec7e07a258dc08486b9883cb6f14610ac7ac6bcb73fc7dbda6c51c06::treasury_f1e {
    struct TREASURY_F1E has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_F1E>, arg1: 0x2::coin::Coin<TREASURY_F1E>) {
        0x2::coin::burn<TREASURY_F1E>(arg0, arg1);
    }

    fun init(arg0: TREASURY_F1E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY_F1E>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREASURY_F1E>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY_F1E>>(v1);
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_F1E>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TREASURY_F1E> {
        0x2::coin::mint<TREASURY_F1E>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_F1E>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY_F1E>>(0x2::coin::mint<TREASURY_F1E>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

