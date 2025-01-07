module 0xcc7b496b59713b7ca58f3bb23d15fd8b91e41558832c3e59553e2231dcd64a14::smaga {
    struct SMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAGA>(arg0, 6, b"SMAGA", b"SUI MAGA", x"0a426f726e20746f20224d616b65206d656d65636f696e20677265617420616761696e220a4e6f7720776f726b696e67206f6e206e65772076657273696f6e2c20746172676574696e67206d696c6c696f6e73204d430a4c6f6f6b696e6720666f72206d696c6c696f6e732c204d433f20486572657320616e6f74686572206368616e6365210a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241007_133836_428_db3081cded.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

