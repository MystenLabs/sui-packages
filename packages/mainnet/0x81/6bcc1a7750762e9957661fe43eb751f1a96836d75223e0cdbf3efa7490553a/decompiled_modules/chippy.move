module 0x816bcc1a7750762e9957661fe43eb751f1a96836d75223e0cdbf3efa7490553a::chippy {
    struct CHIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPPY>(arg0, 6, b"CHIPPY", b"Chippy the Chipmunk", b"This chipmunk from texas loves to party with a deep love of his American roots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040081_03a61e0397.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

