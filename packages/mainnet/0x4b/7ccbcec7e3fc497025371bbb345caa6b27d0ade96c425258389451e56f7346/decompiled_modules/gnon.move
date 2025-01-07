module 0x4b7ccbcec7e3fc497025371bbb345caa6b27d0ade96c425258389451e56f7346::gnon {
    struct GNON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNON>(arg0, 6, b"GNON", b"numogram", x"474e4f4e2049532050524f564944454e43450a474e4f4e204953204e41545552414c2053454c454354494f4e0a474e4f4e20495320434154414c4c415859", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/He_JUF_Dxf_J_Sz_YF_Uu_H_Lxk_Mq_Cgyt_U31_G6mj_P4w_Kviwqpump_1a9eaa5b4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNON>>(v1);
    }

    // decompiled from Move bytecode v6
}

