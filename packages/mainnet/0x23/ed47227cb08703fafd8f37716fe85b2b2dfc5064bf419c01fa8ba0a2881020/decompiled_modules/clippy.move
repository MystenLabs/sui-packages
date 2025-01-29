module 0x23ed47227cb08703fafd8f37716fe85b2b2dfc5064bf419c01fa8ba0a2881020::clippy {
    struct CLIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLIPPY>(arg0, 6, b"CLIPPY", b"Clippy On Sui", b" The AI with a past.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_141653_156_e174e59806.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

