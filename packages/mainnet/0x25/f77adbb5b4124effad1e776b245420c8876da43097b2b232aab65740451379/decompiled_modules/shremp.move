module 0x25f77adbb5b4124effad1e776b245420c8876da43097b2b232aab65740451379::shremp {
    struct SHREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREMP>(arg0, 6, b"SHREMP", b"Shremp", b"I'm set to eclipse Pepe! Brace yourselves for intergalactic laughs with Shrempin memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shrempdisco_0dd9b3a0dc.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

