module 0xc43bfa0ce1e4afc451d0f43cf03ddaf97288cb72d2486c80630f7009e8a090af::bulllguy {
    struct BULLLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLLGUY>(arg0, 6, b"BULLLGUY", b"BullGuy", b"BullGuy is a memecoin on the Sui blockchain, created to bring a new atmosphere to the meme world. With a unique approach, BullGuy aims to be the top among all memecoins, making it an unrivaled icon in the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241111_141510_e2906dbcf9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLLGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLLGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

