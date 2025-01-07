module 0xb5d4d22eaa04848454ac13fa6515e03d4ed41a220952291689cd9cb78416c496::tapcat {
    struct TAPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAPCAT>(arg0, 6, b"TAPCAT", b"TapCat", x"546865206361742074686174206e657665722073746f70732074617070696e672e20496e20686f6e6f72206f6620612066616d6f757320766972616c206d656d652c20616e6420746865206f6273657373696f6e206f662063617473206576657279776865726520746f2074617020736869742072656c656e746c6573736c792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vm_W6_PXFU_8d4hp_T9b_Prx_N2_G89_Wqhw3mkujpe_HJYR_7qm3i_f35f0d9d9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

