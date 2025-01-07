module 0x44dd6b96a0a0fa3052028803abf9accd5f7d58831b816145c49e1648e3973133::cib {
    struct CIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIB>(arg0, 6, b"Cib", b"cat in black", b"cat in black _sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rzg_S_Zj4fwc_T_Yfyzry9_Kdqt97je_Rdzk_ACZ_5_D1_Tfnxq_N3e_13f2c513b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

