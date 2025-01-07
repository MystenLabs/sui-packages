module 0x402056bbac1962b5dab9f38821fd9a4df1807d62ce70d1d548a4b5fa058db1ac::derp {
    struct DERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERP>(arg0, 6, b"DERP", b"Derpman", b"Da da da da da da da da DERPMAN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OSL_2k5_Bq_400x400_f61688988e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

