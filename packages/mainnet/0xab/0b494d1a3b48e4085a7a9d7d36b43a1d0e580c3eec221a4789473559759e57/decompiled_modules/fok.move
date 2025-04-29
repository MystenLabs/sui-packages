module 0xab0b494d1a3b48e4085a7a9d7d36b43a1d0e580c3eec221a4789473559759e57::fok {
    struct FOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOK>(arg0, 6, b"FOK", b"FOK Token", b"LOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd3mro_Fd_Ax_Pcq_Wp7_Dcmvtf3kv_ARH_8g_H_Jy_Hrx94k6tc416_0886667181.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

