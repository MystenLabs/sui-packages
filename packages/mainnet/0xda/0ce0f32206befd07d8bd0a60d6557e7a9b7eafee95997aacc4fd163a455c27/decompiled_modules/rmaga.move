module 0xda0ce0f32206befd07d8bd0a60d6557e7a9b7eafee95997aacc4fd163a455c27::rmaga {
    struct RMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMAGA>(arg0, 6, b"RMAGA", b"RED MAGA", b"RedMaga is a symbol of a new era. Supporting the idea of greatness and leadership, RedMaga unites those who stand for global change and freedom. This is more than just a token  its a voice for the future, where innovation and progress come together with traditional values.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_2d4ed82b2e.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

