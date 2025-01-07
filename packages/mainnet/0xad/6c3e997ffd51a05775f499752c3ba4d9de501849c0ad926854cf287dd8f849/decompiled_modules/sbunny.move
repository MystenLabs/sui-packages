module 0xad6c3e997ffd51a05775f499752c3ba4d9de501849c0ad926854cf287dd8f849::sbunny {
    struct SBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUNNY>(arg0, 6, b"SBunny", b"SuiBunny", b"Bunny meme coin on sui make sui memecoin great again, we are next sui top meme coin , we love bunny, we love sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_fee8d98a24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

