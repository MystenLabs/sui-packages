module 0x3aa24c7d3179c15d99c1a128616eb839e111cc688388bb28faea3d2838c2b7c::jerry {
    struct JERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY>(arg0, 6, b"JERRY", b"JERRY Sui", b"Jeryy meme sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jery_e5f2631fb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

