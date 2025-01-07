module 0xb84ff5293b3cf522cdaa09f56d763f5bdf9367be95b9623de49d7824d2142a5f::aic {
    struct AIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIC>(arg0, 6, b"AIC", b"AI CAT COIN", b"100% AI MEME COIN, DON'T DEV, DON'T TEAM, NOTHING! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_020a23036a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

