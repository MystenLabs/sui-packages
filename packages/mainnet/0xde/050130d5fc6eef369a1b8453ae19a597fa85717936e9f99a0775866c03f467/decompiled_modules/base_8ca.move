module 0xde050130d5fc6eef369a1b8453ae19a597fa85717936e9f99a0775866c03f467::base_8ca {
    struct BASE_8CA has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<BASE_8CA>, arg1: 0x2::coin::Coin<BASE_8CA>) {
        0x2::coin::burn<BASE_8CA>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<BASE_8CA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BASE_8CA> {
        0x2::coin::mint<BASE_8CA>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<BASE_8CA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASE_8CA>>(0x2::coin::mint<BASE_8CA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BASE_8CA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASE_8CA>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BASE_8CA>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASE_8CA>>(v1);
    }

    // decompiled from Move bytecode v6
}

