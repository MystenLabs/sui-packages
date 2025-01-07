module 0xed60f2c0af39865e0579358fde7657b0fe27e271ba18dee1126178a05fd5a278::milady {
    struct MILADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILADY>(arg0, 6, b"Milady", b"Milady on SUI", b"$Milady on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xs_R_Ln_AO_0_400x400_9ac3e8ee20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

