module 0xb435bfb9a324b59c1d24cd97deaa3f96142270f1d09772b6227d7fdd12fb8fb6::spengu {
    struct SPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPENGU>(arg0, 6, b"SPENGU", b"PENGUINonSUI", b"PENGUonSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PINGUIN_81f1cff7a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

