module 0x9baeb13db94cc484e566e8d2368923b8fe9ac0c2d5b4b8a7ecd24a84e1f8d121::bubbles {
    struct BUBBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLES>(arg0, 6, b"BUBBLES", b"Bubbles Sui", b"$BUBBLES meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000242_ff83284105.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

