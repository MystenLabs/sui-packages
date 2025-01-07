module 0x748342ff1cf99dfc3a5669b9dda0cbb4ba397f017fabc70909463ecbafd40ae1::sbulfi {
    struct SBULFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULFI>(arg0, 6, b"Sbulfi", b"SBULFI on Sui", b"SBULFI ON SUI | MOVEPUMP | t.me/blufionsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WDWED_dcbd277cce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

