module 0x5c6aedb9ba1ee4e83fce35d52f9b7fd7ad9bfe58b1e6ec9b53580f5a8af91ad4::service_28a {
    struct SERVICE_28A has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_28A>, arg1: 0x2::coin::Coin<SERVICE_28A>) {
        0x2::coin::burn<SERVICE_28A>(arg0, arg1);
    }

    public fun dispense(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_28A>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SERVICE_28A> {
        0x2::coin::mint<SERVICE_28A>(arg0, arg1, arg2)
    }

    public entry fun dispense_to(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_28A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SERVICE_28A>>(0x2::coin::mint<SERVICE_28A>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SERVICE_28A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERVICE_28A>(arg0, 9, b"wNS", b"Wrapped SuiNS Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SERVICE_28A>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SERVICE_28A>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

