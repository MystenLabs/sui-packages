module 0x607c71a2bdae03bfd7e532620a26c6dbff037fb6a52fc8d12632d4a8b5279c28::suicune {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 6, b"Suicune", b"Sui Cune", x"6865204c6567656e64617279204265617374206f66205355492c2069732062656c696576656420746f20626520626f74682074686520656d626f64696d656e74206f6620746865206e6f7274682077696e647320616e6420636f6d70617373696f6e206f66207075726520737072696e67207761746572732e0a0a53756963756e6520746865206c6567656e64617279207761746572206265617374206973207468652070657266656374206d6173636f7420666f722074686520537569204e6574776f726b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x8c47c0bde84b7056520a44f46c56383e714cc9b6a55e919d8736a34ec7ccb533_suicune_suicune_a051ef9217.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

