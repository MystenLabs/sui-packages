module 0x53b922dbd1a548a8f52ffb879b5adeeabfe182912bd94641095cea9026b331e2::pcon {
    struct PCON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCON>(arg0, 6, b"PCON", b"PepyCon", b"Pepy is here to adjust the new rates.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004400_d7a8625478.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCON>>(v1);
    }

    // decompiled from Move bytecode v6
}

