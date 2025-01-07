module 0x91c789817dffa88fef82fb19ebfce2f0f7ca944e90feff0c8cf77dd9e5eebbc0::cfds {
    struct CFDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFDS>(arg0, 6, b"CFDS", b"CatFrogDogShark", b"Meet CatFrogDogShark2002HondaCivicUnicornInu!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_E_Sb_U_Kju_MY_6jz_DH_9_VP_8cy4p3pu2q5_W2r_K2_Xgh_Vf_Nse_P_7b90110699.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

