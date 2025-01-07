module 0x20017d08474c47a06c376c3e4772feab4ebb84f573e8d8a9045013390437fa72::tuti {
    struct TUTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUTI>(arg0, 6, b"TUTI", b"Tuti", b"Tuti coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_bbffb9da64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

