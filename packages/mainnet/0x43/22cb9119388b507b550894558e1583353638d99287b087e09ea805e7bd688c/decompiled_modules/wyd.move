module 0x4322cb9119388b507b550894558e1583353638d99287b087e09ea805e7bd688c::wyd {
    struct WYD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYD>(arg0, 6, b"WYD", b"Hey babe wyd", x"4865792062616265207779640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeh_Yz1p2m_JDYU_4_X1_W_Ssoj_J_Pg4_V_Dj7d_J_Duz_H_Pt_Zz_Loi_H_Fd_3ab3fc750d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WYD>>(v1);
    }

    // decompiled from Move bytecode v6
}

