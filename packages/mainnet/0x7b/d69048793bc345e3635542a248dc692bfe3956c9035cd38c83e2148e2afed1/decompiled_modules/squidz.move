module 0x7bd69048793bc345e3635542a248dc692bfe3956c9035cd38c83e2148e2afed1::squidz {
    struct SQUIDZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDZ>(arg0, 6, b"SQUIDZ", b"$SQUIDZ | The Tentacle Awakens", x"48652063616d652066726f6d2074686520646565702e204865207361772074686520636861696e2e204865207374617274656420746f20766962652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Tq_Y_8y_C_400x400_e2bc967b7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

