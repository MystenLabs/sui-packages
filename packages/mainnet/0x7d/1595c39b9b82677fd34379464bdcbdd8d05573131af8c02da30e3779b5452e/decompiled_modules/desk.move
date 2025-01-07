module 0x7d1595c39b9b82677fd34379464bdcbdd8d05573131af8c02da30e3779b5452e::desk {
    struct DESK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESK>(arg0, 6, b"DESK", b"CoinDesk", x"4c656164696e672074686520636f6e766572736174696f6e206f6e2074686520667574757265206f66206d6f6e65792e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nlb_Jjd_l_400x400_0fb33b2787.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DESK>>(v1);
    }

    // decompiled from Move bytecode v6
}

