module 0x306a81bdff2d34f09809b99ee76480ae4417289fb6fc23170a4165830e306c51::service_478 {
    struct SERVICE_478 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_478>, arg1: 0x2::coin::Coin<SERVICE_478>) {
        0x2::coin::burn<SERVICE_478>(arg0, arg1);
    }

    fun init(arg0: SERVICE_478, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERVICE_478>(arg0, 9, b"BLUE", b"Bluefin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-mAdcY__an7.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SERVICE_478>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SERVICE_478>>(v1);
    }

    public fun invoke(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_478>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SERVICE_478> {
        0x2::coin::mint<SERVICE_478>(arg0, arg1, arg2)
    }

    public entry fun invoke_to(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_478>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SERVICE_478>>(0x2::coin::mint<SERVICE_478>(arg0, arg1, arg3), arg2);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

