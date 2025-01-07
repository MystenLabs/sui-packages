module 0xcaea8a65a05168278b76688abab61e025839d43fc64343398126def1ee45e32d::suilly {
    struct SUILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLY>(arg0, 6, b"SUILLY", b"SUILLY ON SUI", b"$SUILLY - the cutest otter on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rz_Qe_B_Ma_N_400x400_0de5b912bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

