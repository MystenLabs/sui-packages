module 0x8aff5cdac583f7cb91aebe70a1e42ab49149d9d7ae22cede2a084f51b098a937::breadfish {
    struct BREADFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADFISH>(arg0, 6, b"BreadFish", b"Bread Fish ON SUI", b"https://x.com/breadfish_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_Ac_HS_Hc9_400x400_6fbd0df53f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREADFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

