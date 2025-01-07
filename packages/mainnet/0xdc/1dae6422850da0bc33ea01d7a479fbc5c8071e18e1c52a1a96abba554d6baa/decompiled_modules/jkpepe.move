module 0xdc1dae6422850da0bc33ea01d7a479fbc5c8071e18e1c52a1a96abba554d6baa::jkpepe {
    struct JKPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKPEPE>(arg0, 6, b"JKPEPE", b"Jacked Pepe", x"416c6c2061626f7574207468652070756d70732e204d7573636c652c206d61726b65742c20616e64206d656d65732e204a61636b6564506570652069732070756d70696e6720746f20746865206d6f6f6e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_28_13_05_57_A_digital_illustration_of_Pepe_the_Frog_entirely_blue_including_his_face_with_a_muscular_and_pumped_up_body_showing_extreme_confusion_His_face_is_2efed996cb_77c05d755f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JKPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

