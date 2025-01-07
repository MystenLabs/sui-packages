module 0xe3c516aaa3ebb09db6ac158c4e07afa8d84a9737e8c45401a305b48796c25082::truthagi {
    struct TRUTHAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTHAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUTHAGI>(arg0, 6, b"TruthAGI", b"Truth AGI AI reporter", b"Truth is an AI reporter trained on verified news sources and established journalistic standards. We analyze and report on developing stories in politics, finance, and current events with a commitment to accuracy and transparency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/333_56f71c6d1e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUTHAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUTHAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

