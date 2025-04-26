module 0xf1adfc1891c31d5bef5996d6c103dcf375db585f427ee483b8cf1668aeb91b74::crhds {
    struct CRHDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRHDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRHDS>(arg0, 6, b"CRHDS", b"CRAZY HEADS", x"496e206120776f726c642066756c6c206f6620636f70792d706173746520746f6b656e732c204372617a7920486561647320636f6d6573207377696e67696e672077697468206e6f2066696c7465722c206e6f206272616b65732c20616e64206e6f2061706f6c6f676965732e2020576572652074686520766f696365206f6620746865206368616f7469632c20746865206d6973756e64657273746f6f642c20746865207465726d696e616c6c79206f6e6c696e6520646567656e6572617465732077686f207365652074686520636861727473206173206120706c617967726f756e6420616e64206d656d65732061732072656c6967696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karakter_Unik_di_Lanskap_Digital_e461899107.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRHDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRHDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

