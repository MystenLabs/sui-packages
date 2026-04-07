module 0xa372bd61ca70693f4d27535dad8fd724844c7a93678745412d8dc59e4a282ccf::treasury_d85 {
    struct TREASURY_D85 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_D85>, arg1: 0x2::coin::Coin<TREASURY_D85>) {
        0x2::coin::burn<TREASURY_D85>(arg0, arg1);
    }

    fun init(arg0: TREASURY_D85, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY_D85>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREASURY_D85>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY_D85>>(v1);
    }

    public fun perform(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_D85>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TREASURY_D85> {
        0x2::coin::mint<TREASURY_D85>(arg0, arg1, arg2)
    }

    public entry fun perform_to(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_D85>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY_D85>>(0x2::coin::mint<TREASURY_D85>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

