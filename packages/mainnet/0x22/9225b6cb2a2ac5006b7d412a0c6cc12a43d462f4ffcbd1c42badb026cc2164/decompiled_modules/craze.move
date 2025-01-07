module 0x229225b6cb2a2ac5006b7d412a0c6cc12a43d462f4ffcbd1c42badb026cc2164::craze {
    struct CRAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAZE>(arg0, 6, b"CRAZE", b"Crazy Sui", x"456d627261636520746865206372617a792c20756e6c6561736820796f75722067656e697573210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Meme_char_man_aba6f824c9_31be162b70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

