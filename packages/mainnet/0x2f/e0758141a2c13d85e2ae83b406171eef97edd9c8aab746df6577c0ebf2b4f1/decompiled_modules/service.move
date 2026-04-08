module 0x2fe0758141a2c13d85e2ae83b406171eef97edd9c8aab746df6577c0ebf2b4f1::service {
    struct SERVICE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<SERVICE>, arg1: 0x2::coin::Coin<SERVICE>) {
        0x2::coin::burn<SERVICE>(arg0, arg1);
    }

    fun init(arg0: SERVICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERVICE>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SERVICE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SERVICE>>(v1);
    }

    public fun perform(arg0: &mut 0x2::coin::TreasuryCap<SERVICE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SERVICE> {
        0x2::coin::mint<SERVICE>(arg0, arg1, arg2)
    }

    public entry fun perform_to(arg0: &mut 0x2::coin::TreasuryCap<SERVICE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SERVICE>>(0x2::coin::mint<SERVICE>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

