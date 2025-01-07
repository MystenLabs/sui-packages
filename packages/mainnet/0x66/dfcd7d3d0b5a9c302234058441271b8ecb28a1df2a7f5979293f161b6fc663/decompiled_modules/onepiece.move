module 0x66dfcd7d3d0b5a9c302234058441271b8ecb28a1df2a7f5979293f161b6fc663::onepiece {
    struct ONEPIECE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEPIECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEPIECE>(arg0, 6, b"ONEPIECE", b"Onesuipiece", b"ONE PIECE FAN COIN is an anime meme token created among a strong community of followers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_81_03d6f15d35.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEPIECE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONEPIECE>>(v1);
    }

    // decompiled from Move bytecode v6
}

