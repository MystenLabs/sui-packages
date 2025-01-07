module 0x9954425986bb89b2b5ad1daf5197fdde6ad13bbeaa2d6bf04fd38f1f5911ed68::goose {
    struct GOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOSE>(arg0, 6, b"GOOSE", b"SUIGOOSE", x"546865205375696573742020476f6f7365206f6e2053554920636861696e2e0a436f6d65206a6f696e2074686520676f6f736520636c616e2e0a2a2a2a2a484f4e4b20484f4e4b2a2a2a2a2a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f1642e76_d8d5_476c_b89b_d98c096a3d88_b035dbc732.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

