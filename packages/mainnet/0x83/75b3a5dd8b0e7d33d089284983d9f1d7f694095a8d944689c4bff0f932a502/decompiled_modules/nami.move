module 0x8375b3a5dd8b0e7d33d089284983d9f1d7f694095a8d944689c4bff0f932a502::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 6, b"NAMI", b"SUINAMI", b"Cant stop, wont stop riding the wave of Suinami.  Get ready for a memecoin thats crashing through the crypto scene with unstoppable momentum. Hold on tight, because once this wave hits, theres no turning back!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_A55744_07_A0_45_F5_B96_C_2_EECACDD_268_D_4a79654dd8.WEBP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

