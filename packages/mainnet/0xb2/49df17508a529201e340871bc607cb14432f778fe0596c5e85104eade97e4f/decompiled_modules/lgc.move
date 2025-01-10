module 0xb249df17508a529201e340871bc607cb14432f778fe0596c5e85104eade97e4f::lgc {
    struct LGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGC>(arg0, 6, b"LGC", b"Lazy Gecko COIN", x"4e657720636f696e20746f20486f6c64202046524545204e465420464f52205448452031535420344b204d454d42455253204275636b6c65207570202e2e2e77652066696e6e6120676f20746f20746865206d6f6f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_FBH_6_Rv5_Ks_B1_Dwas7dv_Z_Nj_A7h2_Vo_X7uvp_G3s_WKW_Po_Hd1_4d11fbc906.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

