module 0x310a74e9195344e944cb68e9ebabb24cb0f05103d69145d4f6346f598b6c3148::anikka {
    struct ANIKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIKKA>(arg0, 6, b"ANIKKA", b"Anikka", x"4e5346572041492028414e494b4b41292028414e494b4b41290a416e696b6b6120697320746865206669727374204e534657204149206275696c74206f6e20616931367a73206672616d65776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RW_145_Wny_Zck_X9_XD_5_Yzpu_Xf_E_Mrwpnq_SP_47p_Xo7zy9_QAVR_1efd16a3cb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANIKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

