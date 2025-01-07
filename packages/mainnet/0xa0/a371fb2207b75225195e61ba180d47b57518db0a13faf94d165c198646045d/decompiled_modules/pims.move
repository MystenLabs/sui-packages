module 0xa0a371fb2207b75225195e61ba180d47b57518db0a13faf94d165c198646045d::pims {
    struct PIMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIMS>(arg0, 6, b"PIMS", b"Pims", b"PIMS, a fun blend of the Cheems meme and a pig, brings humor to the SUI blockchain. Fast and low-cost, it promises to deliver meme-driven community engagement with a playful twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MV_Logog_628a2ce3a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

