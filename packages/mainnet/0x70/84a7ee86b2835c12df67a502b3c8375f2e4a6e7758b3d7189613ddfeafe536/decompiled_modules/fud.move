module 0x7084a7ee86b2835c12df67a502b3c8375f2e4a6e7758b3d7189613ddfeafe536::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 6, b"FUD", b"FlyingUltraDugong", x"4e4f2046554420484552450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V_Nxc_Dp_Ht_H_Kcsq_KJW_Kfn5_Ze_Z_Ndpq_Qrg_Sc25_H_Re6_Vj4a_Vi_7a801ed274.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

