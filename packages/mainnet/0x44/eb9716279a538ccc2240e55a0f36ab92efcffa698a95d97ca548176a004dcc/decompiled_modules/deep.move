module 0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEEP>, arg1: 0x2::coin::Coin<DEEP>) {
        0x2::coin::burn<DEEP>(arg0, arg1);
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP ", b"DeepBook Token", b"The DEEP token secures the DeepBook protocol, the premier wholesale liquidity venue for on-chain trading.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.deepbook.tech/icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 10000000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEEP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEEP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

