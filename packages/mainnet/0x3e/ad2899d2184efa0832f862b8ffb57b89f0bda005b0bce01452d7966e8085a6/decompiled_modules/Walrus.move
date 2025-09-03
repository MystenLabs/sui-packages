module 0x3ead2899d2184efa0832f862b8ffb57b89f0bda005b0bce01452d7966e8085a6::Walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 9, b"WALLY", b"Walrus", b"sea monster fren. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz745pWbAAAQ4Wn?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALRUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

