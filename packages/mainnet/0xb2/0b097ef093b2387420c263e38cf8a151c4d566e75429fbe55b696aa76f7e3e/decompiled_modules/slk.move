module 0xb20b097ef093b2387420c263e38cf8a151c4d566e75429fbe55b696aa76f7e3e::slk {
    struct SLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLK>(arg0, 6, b"SLK", b"Suilock AI", b"Suilock Agency  AI meets detective mischief. Solve outrageous cases, climb ranks and flex your sleuthing swagger.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_ezgif_com_optimize_1_672cc6634b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

