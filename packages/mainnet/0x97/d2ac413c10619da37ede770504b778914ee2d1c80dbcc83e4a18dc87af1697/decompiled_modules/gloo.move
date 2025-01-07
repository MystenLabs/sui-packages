module 0x97d2ac413c10619da37ede770504b778914ee2d1c80dbcc83e4a18dc87af1697::gloo {
    struct GLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOO>(arg0, 6, b"GLOO", b"Suigloo", x"0a24474c4f4f206973206e6f74206a7573742061626f7574206d656d6520746f6b656e2c20537569676c6f6f20697320616e2065706963206a6f75726e6579206f6e2053554920574f524c44", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241014_203214_140_a2627f067d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

