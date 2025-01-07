module 0xbe93d1eb761c97b71cf8dfc604727131e83b26120f7279bc130a0c54c297a368::sarti {
    struct SARTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARTI>(arg0, 6, b"SARTI", b"Suiboy Carti", x"507573737920617373206e69676761206a7573742074616c6b20736869740a507573737920617373206e69676761206a7573742074616c6b20736869740a5468656d207075737379206e69676761732061696e27742027626f7574207468617420736869740a5468656d207075737379206e69676761732061696e27742027626f757420746861742073686974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artworks_so_B_Sgak6_K_Qm_IW_8it_q_GNA_Fw_t500x500_dd477a34a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

