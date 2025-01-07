module 0x27f82bebf06fa8a185aa705eb3554a14c395b238424d30048ac3d0100dbd98cb::spump {
    struct SPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUMP>(arg0, 6, b"SPUMP", b"SuiPump", b"The Leading Meme Fair Launch Platform.Verified. suipump.meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w9_N2_FJYF_400x400_a7897a4c96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

