module 0xccb18907b11729d221493ed95cd5b3b0ab40b10f440a1e42b4b12bc91b28388e::peku {
    struct PEKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEKU>(arg0, 6, b"PEKU", b"PEKU ON SUI", x"4a6f696e20757320616e64206c6574277320676574207468652037207375692062616c6c7320746f6765746865722077697468202450454b55204920616d2074686520646576656c6f706572206f6620244e4f5448494e472e20596f75206b6e6f772074686174204920646f6e27742073656c6c20616e64207468617420492070617920666f72206d61726b6574696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_Hh_Ysi_IT_400x400_2cd40189a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

