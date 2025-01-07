module 0xf292959f6f0ddede16b95bde32b6fac48c7125e5ae1733e7f28a104995b1824f::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SU>(arg0, 6, b"SU", b"Sui Universe", b"$SU - \"Sui Universe\" is mirroring Sui Network capabilities . Join Us - https://t.me/suiuniversesui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_N_Qpil_Ih_400x400_c6514e10f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SU>>(v1);
    }

    // decompiled from Move bytecode v6
}

