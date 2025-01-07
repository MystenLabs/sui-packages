module 0x3789f53561bea0bb7f6e3ea6fe8366dc59a18014ad994ca5d30e0891716f93a6::cipher {
    struct CIPHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIPHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIPHER>(arg0, 6, b"CIPHER", b"Cipher Nakamoto", x"4369706865722c205361746f736869204e616b616d6f746f2773204149206361742c2063616d6520696e746f206265696e67207468726f75676820746865206469676974616c206d6174726978206f6620436861744750542e2057697468696e2074686520696e7472696361746520776562206f6620616c676f726974686d7320616e6420646174612c206120756e69717565206d616e69666573746174696f6e206f636375727265642c20676976696e67207269736520746f20612073656e7469656e742066656c696e6520656e746974792e2052656d656d62657220427974652c20456c6f6e277320416920646f672e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CIPHER_TJ_3_G_Xh_wb_Qts7_HP_Zx4k_61184af843.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIPHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIPHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

