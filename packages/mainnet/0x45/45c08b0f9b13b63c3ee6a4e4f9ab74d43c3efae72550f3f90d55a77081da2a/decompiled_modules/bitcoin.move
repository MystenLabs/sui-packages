module 0x4545c08b0f9b13b63c3ee6a4e4f9ab74d43c3efae72550f3f90d55a77081da2a::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 6, b"Bitcoin", b"Is this Satoshi", b"Where is Satoshi ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1970_0f9b643998.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

