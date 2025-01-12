module 0xcecd2e90055cc44065aa435bdb572c97c1eeadfe3e4fe2116c42429a33e4af9f::turbofox {
    struct TURBOFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOFOX>(arg0, 6, b"TURBOFOX", b"Turbo Fox", x"547572626f20466f7820697320746865206661737465737420666f7820666f7220626f747320746f207573650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vh_F1i_Pruyo_J1541_Cu_Kobb_K_Hbbov9d_U5928_G8_Wg_DHNB_6s_68825b3b56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBOFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

