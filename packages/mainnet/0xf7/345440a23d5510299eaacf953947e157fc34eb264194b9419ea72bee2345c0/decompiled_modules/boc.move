module 0xf7345440a23d5510299eaacf953947e157fc34eb264194b9419ea72bee2345c0::boc {
    struct BOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOC>(arg0, 6, b"BOC", b"Book of Christmas", x"45766572796f6e65206761746865722061726f756e6420616e6420656e6a6f79207468652073746f7279206f662074686520426f6f6b206f66204368726973746d61732e20416c6c20796f7572206661766f726974652073746f7269657320616e64206368617261637465727320636f6d62696e656420696e206f6e6520617765736f6d6520616476656e747572652061626f75742065766572796f6e652773206661766f757269746520686f6c696461792c204368726973746d61730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vk_Gy_RYFQHKA_Fw_Rm_UG_Zs_MU_6t_So3g9ji_Qs_TLYY_Hs1x_QQ_3_W_50e902fb67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

