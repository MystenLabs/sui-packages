module 0xfb8fddfe13851922203816ef5d289ffe9bf4ea28659031273223bdc731d482ba::octosui {
    struct OCTOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOSUI>(arg0, 6, b"OCTOSUI", b"OCTOS", x"54686520626c75657374206f63746f707573206f6e205355492e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x2d7ca162cf86afbeb041eedeba6659ca8ebdc029869a25970c76ac30429a7eb0_octo_octo_938083ba7d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

