module 0x94a742a675d314094b3aa5190e464887cedd2a1f2d5b16e8966e5af8a39549a::rcat {
    struct RCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCAT>(arg0, 6, b"RCAT", b"RCAT ON SUI", b"$RCAT - The rocket is sending ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wb5ja6r_DW_7_Qkv_C_Fun_DRV_Hzepqjq_XY_64srzy_Knn_L9j_Gm_D_399aa13fa6.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

