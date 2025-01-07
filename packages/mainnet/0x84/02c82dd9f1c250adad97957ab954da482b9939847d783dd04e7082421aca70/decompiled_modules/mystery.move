module 0x8402c82dd9f1c250adad97957ab954da482b9939847d783dd04e7082421aca70::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTERY>(arg0, 6, b"Mystery", b"Sui Horse", b"Because of her mysterious behavior, I have decided to name her Mystery.Hiyaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2df96e57640e31b26877e1ddf0f581477c79cfc8_s2_n2_y1_6c2cb8e472.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYSTERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

