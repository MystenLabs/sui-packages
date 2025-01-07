module 0x5ee6b3a3b4ce8605f217b52d6e6c322ab49624f2728eaf02c3b7c19c208177ee::fwog {
    struct FWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOG>(arg0, 6, b"FWOG", b"Fwog", x"313078203f2031303058203f203130303058203f206e6f206e6f206e6f0a7765206e656564203130302420746f203130303030303020736f20697473206d65616e20313030303058203f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722495145731_0bce9b1f0575e791a726e394422776ea_881ba231ad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

