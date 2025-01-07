module 0x9d795394b5fe9a792ff60bad113486d36fe43ca8e52b1eabefcfcd1a1f707d55::hater {
    struct HATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HATER>(arg0, 6, b"HATER", b"Hater Club", b"We always miss the best meme coins. Join us haters and lets 100x ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rubbers_c386e62603.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

