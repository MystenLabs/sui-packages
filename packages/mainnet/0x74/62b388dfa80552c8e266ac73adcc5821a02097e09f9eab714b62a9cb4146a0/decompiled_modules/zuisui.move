module 0x7462b388dfa80552c8e266ac73adcc5821a02097e09f9eab714b62a9cb4146a0::zuisui {
    struct ZUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUISUI>(arg0, 6, b"ZUISUI", b"ZUI", b"At the heart of innovation and security, the ZZ Token logo symbolizes agility and trust in the blockchain space. The sleek, stylized snake elegantly wraps around the initials ZZ, representing both the rapid, seamless movement of digital transactions and the protective strength of cutting-edge technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F227297_C_C35_F_4_BDB_A1_F1_7_C6_A3_AE_461_BB_f6ba9b1f9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

