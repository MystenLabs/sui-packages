module 0x80b9b56f72dd9b01e22fc2b6ac769cf415b747c0436b2c8eeaacfedd95aa26c4::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"The First Dev", x"48652077686f2063726561746564207468652073696d756c6174696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z2d_CW_7pzi_Mu6qpp_Mp7_E1sdqqr4_Ar_Go_YZCE_Fp8n_D_Xwrgp_6db2d67c74.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

