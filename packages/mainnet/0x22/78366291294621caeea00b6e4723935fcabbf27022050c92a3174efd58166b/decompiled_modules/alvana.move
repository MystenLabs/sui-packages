module 0x2278366291294621caeea00b6e4723935fcabbf27022050c92a3174efd58166b::alvana {
    struct ALVANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALVANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALVANA>(arg0, 6, b"ALVANA", b"Alvana Ai", b"Create lifelike AI avatars with Alvana AI. Faces, voices, and animations at your fingertips!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeh8x_WMJ_5_FN_Cp_Lx_Cnfjf_LXU_Cc_QEZBQY_Gb93_UQ_Eb8jgo_Pf_5c331cfabe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALVANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALVANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

