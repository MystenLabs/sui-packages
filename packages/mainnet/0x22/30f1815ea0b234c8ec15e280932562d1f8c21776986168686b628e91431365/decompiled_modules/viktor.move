module 0x2230f1815ea0b234c8ec15e280932562d1f8c21776986168686b628e91431365::viktor {
    struct VIKTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIKTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIKTOR>(arg0, 6, b"VIKTOR", b"Viktor", x"56696b746f7220697320746865206669727374206d756c7469636861696e206d656d6520636f696e2e205468652070726f6a65637420697320696e73706972656420627920612031342d796561722d6f6c64207363686f6f6c626f79206e616d65642056696b746f722c2077686f2069732070617373696f6e6174652061626f7574206261736b657462616c6c2c20766964656f2067616d65732c20616e642063727970746f63757272656e63792e200a574849544550415045523a68747470733a2f2f76696b746f722d636f696e2e676974626f6f6b2e696f2f76696b746f722d77686974657061706572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725101002616_40026f66fef3c73c291b66620f3b3d6b_08666fcbbb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIKTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIKTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

