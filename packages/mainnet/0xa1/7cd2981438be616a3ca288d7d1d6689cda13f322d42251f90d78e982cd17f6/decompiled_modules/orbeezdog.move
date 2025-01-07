module 0xa17cd2981438be616a3ca288d7d1d6689cda13f322d42251f90d78e982cd17f6::orbeezdog {
    struct ORBEEZDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBEEZDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBEEZDOG>(arg0, 6, b"OrbeezDog", b"Orbeez", b"$Orbeez is the most daring dog on the blockchain. He only eats Orbeez and Jeets, and the occasional bacon egg & cheese sandwich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zg_GGAEXAAI_Sb_Ka_2ec984b20c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBEEZDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORBEEZDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

