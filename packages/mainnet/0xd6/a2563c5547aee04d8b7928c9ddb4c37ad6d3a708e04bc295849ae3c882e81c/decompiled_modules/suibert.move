module 0xd6a2563c5547aee04d8b7928c9ddb4c37ad6d3a708e04bc295849ae3c882e81c::suibert {
    struct SUIBERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBERT>(arg0, 6, b"SUIBERT", b"Suibert", b"The ultimate token to escape an unbearable job", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suibert_db2ed383f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

