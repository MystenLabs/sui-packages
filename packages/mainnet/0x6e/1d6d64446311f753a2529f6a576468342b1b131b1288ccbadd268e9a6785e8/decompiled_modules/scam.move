module 0x6e1d6d64446311f753a2529f6a576468342b1b131b1288ccbadd268e9a6785e8::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM>(arg0, 6, b"SCAM", b"JEETED BY HOLDER AND SCAMMED BY DEV", x"4f4e4c592046554420414c4c4f5745442e200a4f4e4c59204a45455420414c4c4f5745442e0a4e4547415449564520564942455320484552452e0a484f4c444552204953204a4545544552204a454544544544205343554d424147205452415348204944494f5420415353484f4c450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chaotix_sonic_b4121769c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

