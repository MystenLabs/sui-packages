module 0x7e84da373ab5ff6b022c5b41a65375331c57a06e4f03395048fc680b8f7a504f::rc {
    struct RC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RC>(arg0, 6, b"RC", b"Rocket Cat", x"526f636b657420436174205a6f6f6d696e6720746f20746865204d6f6f6f6f6f6f6f6f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rz_Vv_D_Xd_Mtori2_C_Jpyb_S_Cqywqx_Kzn_F_Gd_S_Ng5m_L_Zp63_N_Lu_42b2099309.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RC>>(v1);
    }

    // decompiled from Move bytecode v6
}

