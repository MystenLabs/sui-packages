module 0x8e013df800fea1647f4c3d55330c249cdb8e4bb816a4384b9dbf807e5213d780::stonk6900 {
    struct STONK6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONK6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONK6900>(arg0, 6, b"STONK6900", b"STONK 6900", x"53544f4e4b53363930302069732074686520646567656e732073746f636b2063686f6963652e200a0a0a54656c656772616d3a2068747470733a2f2f742e6d652f53746f6e6b363930305f43544f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3784_3f53038d12.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONK6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONK6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

