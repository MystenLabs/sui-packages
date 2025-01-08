module 0xaecde57152b6d7e94271958982d80e099f38a16f3dc05474810f1c90028aa90e::pepeai {
    struct PEPEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEAI>(arg0, 6, b"PEPEAI", b"Pepe AI", x"4a75737420616e20414920506570652073686172696e67206d792074686f75676874732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeo_Vt_Pt_Ei_MZL_8_E1_Trk6_S68h_Gcx_JNCZC_Tb_PQA_Xd23h9cgy_41db7b0fc7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

