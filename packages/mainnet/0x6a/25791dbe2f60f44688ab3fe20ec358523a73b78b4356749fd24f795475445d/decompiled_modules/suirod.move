module 0x6a25791dbe2f60f44688ab3fe20ec358523a73b78b4356749fd24f795475445d::suirod {
    struct SUIROD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROD>(arg0, 6, b"SUIROD", b"Sui Rod", b"Cast your line with Sui Rod! The ultimate fishing rod on Sui, perfect for reeling in whatever the deep sea has to offer. Ready to hook the big catch?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rod_a1b7ca064b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROD>>(v1);
    }

    // decompiled from Move bytecode v6
}

