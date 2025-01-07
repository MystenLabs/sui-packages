module 0x70f97bf07025e1d0a093cf1c05b2bbbc58895139bfece22980f3b7d127ce775::xcog {
    struct XCOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCOG>(arg0, 6, b"Xcog", b"xcog", b"if you want the lore behind $xcog, check out xenocognition.com. the whole world is made for us and this whole blog was made for you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241019_033412_81d122d3f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XCOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

