module 0x15c312117bbf46d24718847f6afbacc5372e4641e1a27b96d8d05f2b214c5e37::bottle {
    struct BOTTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTTLE>(arg0, 6, b"BOTTLE", b"Bottle", b"Bottle ($BOTTLE) is a fun, casual meme coin that celebrates the flow of water, liquidity, and all things refreshing. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bottle_icon_d326d2e3a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOTTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

