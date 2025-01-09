module 0x4aaa517e5c8315046332d8d4f211e7d8809b5cd79ea34f09b931d4d18bbd74fe::taa {
    struct TAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAA>(arg0, 6, b"TAA", b"Tako AI Agent", b"Tako AI Agent ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdpvtt_Tr_SY_Ek7z_FNYVK_Tf_Mt_YMAN_8i_SWP_5rk_SH_791m4_Qzu_7c8c892410.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

