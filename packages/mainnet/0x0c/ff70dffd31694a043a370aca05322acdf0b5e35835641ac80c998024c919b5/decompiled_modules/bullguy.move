module 0xcff70dffd31694a043a370aca05322acdf0b5e35835641ac80c998024c919b5::bullguy {
    struct BULLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLGUY>(arg0, 6, b"BULLGUY", b"BullGuy", b"BullGuy is a memecoin on the Sui blockchain, created to bring a new atmosphere to the meme world. With a unique approach, BullGuy aims to be the top among all memecoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241111_141510_7bda6faf6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

