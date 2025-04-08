module 0x6fb9aeb1d668534c6615b0fb816f8a4c54d460f3244b118e4b6d93d985c571dc::usdp {
    struct USDP has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDP>>(0x2::coin::mint<USDP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDP>(arg0, 6, b"USDP", b"USDP", b"Sui token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/paxos-standard-paxos-logo.png?v=040")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

