module 0xab29b1389e003e3bcad54abebd7b7402473614e16a39802b634afbe326c88942::schizo {
    struct SCHIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHIZO>(arg0, 6, b"SCHIZO", b"SUICHIZO", x"456e74696172206d726b7420697a20676f696e20736368697a6f2e0a4c6574732067657420746f676574687220616e64206c6973746e2032206420766f6963657320696e206f777220686564732e0a4a6f6a6e2064206b756c7421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vh_I9f_5_Y_400x400_4c84df05b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

