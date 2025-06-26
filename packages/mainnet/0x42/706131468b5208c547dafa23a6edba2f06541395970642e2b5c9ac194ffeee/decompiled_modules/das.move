module 0x42706131468b5208c547dafa23a6edba2f06541395970642e2b5c9ac194ffeee::das {
    struct DAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAS>(arg0, 6, b"DAS", b"asdsad", b"asdsad asdsad asdsad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr3vmvte3fso3em65fsfra2fvzl4a7x3boabz63uluh3tgyhb6ve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

