module 0x25b94c973681c805d547c35b2549749a94767c45d73637d5db4ad43e7311db1d::cooker {
    struct COOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOKER>(arg0, 6, b"COOKER", b"COOKER SUI", x"576520617265206c69766520636f6f6b696e67207570206f6e20737569210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/97d227_Wdy_Wa9_Ldo_Viby_QN_Ss_SRZ_Guq_V_Qi19_YCU_9_X_Ypump_63e3a80db6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

