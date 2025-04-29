module 0xbbe2c39584a433a6b9ec2e1fec42e6b3a88d25acf04f71c762da02fb058fbf42::gog {
    struct GOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOG>(arg0, 6, b"GOG", b"GOGI", b"Fke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd3mro_Fd_Ax_Pcq_Wp7_Dcmvtf3kv_ARH_8g_H_Jy_Hrx94k6tc416_d443fcad11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

