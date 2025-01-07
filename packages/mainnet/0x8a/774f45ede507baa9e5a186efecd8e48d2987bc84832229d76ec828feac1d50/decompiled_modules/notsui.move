module 0x8a774f45ede507baa9e5a186efecd8e48d2987bc84832229d76ec828feac1d50::notsui {
    struct NOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTSUI>(arg0, 6, b"NotSui", b"Not On Sui", x"22446f6e2774204d697373204f7574206f6e204f776e696e67204e4f545355493a204a61636b706f74204c6f7474657279205469636b657473206f6e20537569204e6574776f726b22200a0a20436f6d706172696e672074686520776f726b206f66206f776e696e6720224e4f545355492220746f20627579696e672061206c6f7474657279207469636b65742c206372656174696e6720612073656e7365206f66206c75636b20616e642068696768206578706563746174696f6e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_19_cd96ad3c80.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

