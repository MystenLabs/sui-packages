module 0x833f4eb64a33005689d60742c548a22a3dda3405400cdc276577c06ecade947c::service {
    struct SERVICE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<SERVICE>, arg1: 0x2::coin::Coin<SERVICE>) {
        0x2::coin::burn<SERVICE>(arg0, arg1);
    }

    public fun grant(arg0: &mut 0x2::coin::TreasuryCap<SERVICE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SERVICE> {
        0x2::coin::mint<SERVICE>(arg0, arg1, arg2)
    }

    public entry fun grant_to(arg0: &mut 0x2::coin::TreasuryCap<SERVICE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SERVICE>>(0x2::coin::mint<SERVICE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SERVICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERVICE>(arg0, 9, b"wSCA", b"Wrapped Scallop", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-jafPKiKKMb.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SERVICE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SERVICE>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

