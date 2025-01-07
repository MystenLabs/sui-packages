module 0xea7f5a3064ae0be0c86dfd37da362ab31b84fb04b2ddb27aa359376f7cfb428f::reee {
    struct REEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REEE>(arg0, 6, b"REEE", b"Reee", x"5065706573206661766f7269746520776f72642120225245454522206973206f6674656e20757365642062792050657065207768656e20686573206672757374726174656420616e6420616e6772792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbr1i4x_Pm_HT_Acto_XJV_4_Fcbk_Wuhj_Fc_Cx_L_Ff4vk_Q1_GHQHXX_e25e4ca347.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

