module 0x475247886ea521c86de6f1def84038b64580e73fcf61d7c4a306c8db46acbbdd::bottle {
    struct BOTTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTTLE>(arg0, 6, b"Bottle", b"BOTTLE", b"Bottle ($BOTTLE) is a fun, casual meme coin that celebrates the flow of water, liquidity, and all things refreshing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bottle_icon_3a18ec1e0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOTTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

