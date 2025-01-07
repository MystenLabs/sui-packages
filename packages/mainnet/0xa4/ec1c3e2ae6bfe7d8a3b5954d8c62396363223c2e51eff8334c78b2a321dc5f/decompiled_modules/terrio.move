module 0xa4ec1c3e2ae6bfe7d8a3b5954d8c62396363223c2e51eff8334c78b2a321dc5f::terrio {
    struct TERRIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERRIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERRIO>(arg0, 6, b"Terrio", b"First Nigga on Sui", b"First Nigga On Sui, I am taking over this blockchain, you will all love me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/terio_umm_6313e275fb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERRIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERRIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

