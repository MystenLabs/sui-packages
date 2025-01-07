module 0x849c4f1f42b3c1648147edfb6b01cf11e1a559a9183fdf424ddfd6a12034c359::agegap {
    struct AGEGAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGEGAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGEGAP>(arg0, 6, b"AGEGAP", b"Agegap Coin", b"Join the AgeGap community and explore a fun, inclusive cryptocurrency that bridges generational divides with humor and connection through our unique meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049441_d509edb5f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGEGAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGEGAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

