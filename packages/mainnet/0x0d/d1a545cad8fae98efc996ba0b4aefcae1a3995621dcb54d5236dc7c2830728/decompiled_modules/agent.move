module 0xdd1a545cad8fae98efc996ba0b4aefcae1a3995621dcb54d5236dc7c2830728::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"SUI AGENT MOO", x"466f72207468652063727970746f2066616d21200a4c657473206272696e6720746865206a75737469636520766962657321200a436f6c6c6563742074686f7365206761696e7320616e642064697669646520746865206c6f6f7421200a4f7264696e61727920747261646572732c20697473206f75722074696d6520746f207368696e652120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kfeyl_8d18b5048b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

