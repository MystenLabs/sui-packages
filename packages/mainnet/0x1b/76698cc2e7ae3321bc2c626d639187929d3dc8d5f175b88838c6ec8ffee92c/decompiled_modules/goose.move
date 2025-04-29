module 0x1b76698cc2e7ae3321bc2c626d639187929d3dc8d5f175b88838c6ec8ffee92c::goose {
    struct GOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOSE>(arg0, 6, b"GOOSE", b"Sui Goose", x"53554920474f4f5345202824474f4f5345290a54686520637962657270756e6b20686f6e6b207265766f6c7574696f6e2074616b657320666c69676874206f6e207468652053756920626c6f636b636861696e2e0a3130302520666169726c61756e63682e204e6f2056432e0a4a6f696e2074686520756e73746f707061626c6520537569476f6f7365206d6f76656d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_13_ec6cf7f245.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

