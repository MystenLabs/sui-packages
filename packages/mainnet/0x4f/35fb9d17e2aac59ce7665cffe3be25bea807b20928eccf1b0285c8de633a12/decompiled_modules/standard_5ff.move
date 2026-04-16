module 0x4f35fb9d17e2aac59ce7665cffe3be25bea807b20928eccf1b0285c8de633a12::standard_5ff {
    struct STANDARD_5FF has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_5FF>, arg1: 0x2::coin::Coin<STANDARD_5FF>) {
        0x2::coin::burn<STANDARD_5FF>(arg0, arg1);
    }

    public fun distribute(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_5FF>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STANDARD_5FF> {
        0x2::coin::mint<STANDARD_5FF>(arg0, arg1, arg2)
    }

    public entry fun distribute_to(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_5FF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STANDARD_5FF>>(0x2::coin::mint<STANDARD_5FF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STANDARD_5FF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANDARD_5FF>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<STANDARD_5FF>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STANDARD_5FF>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

