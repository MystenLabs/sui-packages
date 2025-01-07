module 0x5a1119aedf84f008fb76f0a6c62db2af0e0805668a1c9871e50d52fb3ddcb9d::bambit {
    struct BAMBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMBIT>(arg0, 6, b"BAMBIT", b"BAMBIT on SUI", b"Were aiming to create the most bam-tastic, panda-loving, meme-sharing community of the SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_X4i_Vx_Pv_400x400_e50bad4d56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAMBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

