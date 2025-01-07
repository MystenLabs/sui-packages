module 0x92c84722a3b266ee143b77fec3a8e77ed4cae47f8cf551b11c6c6941d8ca0f82::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 6, b"PIG", b"Pig", b"Pig Token: Where Sunshine Meets Pig!  Pigs are the brightest stars in the Meme Token universe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUNPIG_TQD_Lep_r_IQ_3_Ta_Psaw1_Z_011362c576.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

