module 0x9f7ccf84641b6b8eb485e98de47e62d88f83c16dcf32d2efd7f43f241d8dbcdc::coolshark {
    struct COOLSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLSHARK>(arg0, 6, b"COOLSHARK", b"Cool Shark wif AK", x"436f6f6c20536861726b2077696620414b2072756e7320746865205375692077697468206e6f2061706f6c6f676965732e2041726d656420616e642064616e6765726f75732c207468697320736861726b2069736e74206865726520746f207377696d2c20686573206865726520746f20646f6d696e6174652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_cartoon_design_of_ashark_with_sunglasses_firing_an_ak_fea34dd3_77fd_4d64_9219_4a63184a0dc0_1_b2ef711ef0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOLSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

