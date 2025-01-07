module 0x674a9796eadc7039e946d0addc74cc408fbc087a3cffec3eea0e3d8ae9c3be53::moby {
    struct MOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBY>(arg0, 6, b"MOBY", b"Moby", b"A SUI ORIGINAL! BE A FOUNDER! BE A PLONEER!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Dz_D_g_Fp_400x400_dede42127c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

