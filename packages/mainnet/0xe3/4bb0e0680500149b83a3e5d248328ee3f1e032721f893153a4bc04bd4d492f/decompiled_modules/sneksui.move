module 0xe34bb0e0680500149b83a3e5d248328ee3f1e032721f893153a4bc04bd4d492f::sneksui {
    struct SNEKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEKSUI>(arg0, 6, b"SNEKSUI", b"SNEK SUI", b"Looks like your having trading problemsss, let me take a looksss. Meet $snek will help out with the marketssss.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_22_53_51_85e630ccaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

