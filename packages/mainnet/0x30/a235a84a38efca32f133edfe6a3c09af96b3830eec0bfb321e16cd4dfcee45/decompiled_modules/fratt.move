module 0x30a235a84a38efca32f133edfe6a3c09af96b3830eec0bfb321e16cd4dfcee45::fratt {
    struct FRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRATT>(arg0, 6, b"FRATT", b"Frogg & Ratt", b"Meet Frogg and Ratt. The 2 degens riding the Suinami!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fratt_6651b0c606.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

