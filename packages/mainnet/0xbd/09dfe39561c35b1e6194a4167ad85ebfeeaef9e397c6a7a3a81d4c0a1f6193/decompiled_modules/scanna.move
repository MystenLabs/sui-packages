module 0xbd09dfe39561c35b1e6194a4167ad85ebfeeaef9e397c6a7a3a81d4c0a1f6193::scanna {
    struct SCANNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCANNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCANNA>(arg0, 6, b"SCANNA", b"Stellar Cannacoin", b"Stellar Cannacoin is community rewards token for the cannabis community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026524_e5fc90f775.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCANNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCANNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

