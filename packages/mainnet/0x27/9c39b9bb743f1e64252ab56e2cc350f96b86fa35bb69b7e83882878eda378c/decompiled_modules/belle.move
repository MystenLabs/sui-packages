module 0x279c39b9bb743f1e64252ab56e2cc350f96b86fa35bb69b7e83882878eda378c::belle {
    struct BELLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLE>(arg0, 6, b"BELLE", b"Belle Dolphine", b"first #NSFW onlyfans model on Sui. Automated by Ai, sexy and useful, with a subscription to burn model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jj_ad0841b61a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

