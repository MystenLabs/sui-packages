module 0xbed84ba326d30a006ee523a2df69d2a4c7807facee83f203d67529a1c1142794::exodus {
    struct EXODUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXODUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXODUS>(arg0, 6, b"EXODUS", b"Exodus", b"Exodus Labs Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/exodus_abffa973d4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXODUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EXODUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

