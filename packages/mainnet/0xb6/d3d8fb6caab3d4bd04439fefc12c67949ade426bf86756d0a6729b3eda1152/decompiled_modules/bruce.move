module 0xb6d3d8fb6caab3d4bd04439fefc12c67949ade426bf86756d0a6729b3eda1152::bruce {
    struct BRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCE>(arg0, 6, b"BRUCE", b"BRUCE the SHARK", x"464953482041524520465249454e44532c204e4f5420464f4f44210a2442525543452069736e74206a75737420616e6f746865722066697368207377696d6d696e6720696e2074686520537569207365612c20686527732074686520477265617420576869746520536861726b20646f6d696e6174696e6720746865204f6365616e206f66204c6971756964697479212044697665206465657020776974682074686520426967204669736820616e64207377696d20746f2074686520746f702077697468207468652041706578205072656461746f72206f66207468652053756920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4979_6f002a3b7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

