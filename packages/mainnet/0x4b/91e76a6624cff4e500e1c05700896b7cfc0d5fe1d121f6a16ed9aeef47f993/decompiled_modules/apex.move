module 0x4b91e76a6624cff4e500e1c05700896b7cfc0d5fe1d121f6a16ed9aeef47f993::apex {
    struct APEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEX>(arg0, 6, b"APEX", b"Apex Infinitus", x"4170657820496e66696e697475732077696c6c20726573746f72652062616c616e636520746f20746865206d656d6520756e6976657273652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmctbx2d3hni_Euremx_B5_Y6_L2_Vp_FCSDP_Dd17y9_H_Bwpniz_Hn_1eb9959a93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

