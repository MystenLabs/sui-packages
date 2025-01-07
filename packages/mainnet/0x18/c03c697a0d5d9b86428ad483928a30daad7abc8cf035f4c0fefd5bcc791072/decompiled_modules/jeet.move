module 0x18c03c697a0d5d9b86428ad483928a30daad7abc8cf035f4c0fefd5bcc791072::jeet {
    struct JEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEET>(arg0, 6, b"JEET", b"SUIJEET", b"**Community Takeover**.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_Gk_Di_S_Mg_400x400_af2dcbda17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

