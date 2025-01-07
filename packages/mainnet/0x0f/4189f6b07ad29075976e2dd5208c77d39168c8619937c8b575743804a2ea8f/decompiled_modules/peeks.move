module 0xf4189f6b07ad29075976e2dd5208c77d39168c8619937c8b575743804a2ea8f::peeks {
    struct PEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEKS>(arg0, 6, b"PEEKS", b"Peeks cat", x"5065656b7320436174206265656e206c75726b696e6720696e2074686520736861646f77732c207761746368696e67206576657279206d6f7665207769746820736861727020696e7374696e6374732e205768656e20746869732063617420706f756e6365732c20796f756c6c2077616e7420746f20626520726561647920736f6d657468696e67732061626f757420746f20676f20646f776e2e0a0a576562736974653a2068747470733a2f2f7065656b6f6e7375692e66756e0a547769747465723a2068747470733a2f2f782e636f6d2f5065656b4f6e5375690a54656c656772616d3a2068747470733a2f2f742e6d652f5065656b43617453", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250106_045824_111_bfa775cf4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

