module 0x3d6238a23ba88b1a7b81ce9768141f627c2cd24c6c5f6b3dff6bdb36d9c45b37::nggastlmybke {
    struct NGGASTLMYBKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGGASTLMYBKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGGASTLMYBKE>(arg0, 6, b"Nggastlmybke", b"Nigga stole my bike", b"Nigga stole my bike ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1265_a565bfd5d6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGGASTLMYBKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGGASTLMYBKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

