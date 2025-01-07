module 0xc069d135f3a4590f6d67098087d3c18a7624f1e80195808c4baa43ead2b1d95::suni {
    struct SUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNI>(arg0, 6, b"SUNI", b"SUI INU", x"4c657427732074616b652063617265206f662074686520646f67732c20616e6420746865792077696c6c2072656d61696e206c6f79616c20746f2075732e206265737420667269656e642053554e490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_tasar_Ae_m_1_0fc338a056.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

