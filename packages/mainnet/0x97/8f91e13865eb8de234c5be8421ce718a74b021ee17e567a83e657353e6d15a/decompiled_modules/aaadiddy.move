module 0x978f91e13865eb8de234c5be8421ce718a74b021ee17e567a83e657353e6d15a::aaadiddy {
    struct AAADIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADIDDY>(arg0, 6, b"AAADIDDY", b"AAA Diddy", b"Can't stop won't stop (thinking about minors)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Your_paragraph_text_71_d3f793637e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

