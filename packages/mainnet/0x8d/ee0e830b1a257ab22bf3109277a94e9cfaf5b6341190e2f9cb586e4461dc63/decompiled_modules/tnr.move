module 0x8dee0e830b1a257ab22bf3109277a94e9cfaf5b6341190e2f9cb586e4461dc63::tnr {
    struct TNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNR>(arg0, 6, b"TNR", b"THE NOBEL PRIZE ON SUI", b"THE NOBEL PRIZE ON SUIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_V_Pd0_Ew_X_400x400_936b6fb4c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

