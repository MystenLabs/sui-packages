module 0x1493c922b8e116fd000353a6d0c3b998d83e9381b14eee6c3b510116438a7009::bluxie {
    struct BLUXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUXIE>(arg0, 6, b"Bluxie", b"Bluxie Sui", b"Bluxie is the chaotic blue pup of Sui. A meme, a movement, a bark heard 'round the chain, just vibesand maybe a moon or two.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9581_bfaf4e6c1a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUXIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUXIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

