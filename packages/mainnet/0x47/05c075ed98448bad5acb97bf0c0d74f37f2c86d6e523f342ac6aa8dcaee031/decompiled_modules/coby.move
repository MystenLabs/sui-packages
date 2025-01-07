module 0x4705c075ed98448bad5acb97bf0c0d74f37f2c86d6e523f342ac6aa8dcaee031::coby {
    struct COBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBY>(arg0, 6, b"COBY", b"COBY SUI", b"Once you're in the cult - $COBY becomes your best friend forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_WO_Nh6_Pp_400x400_bb70bd0dcc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

