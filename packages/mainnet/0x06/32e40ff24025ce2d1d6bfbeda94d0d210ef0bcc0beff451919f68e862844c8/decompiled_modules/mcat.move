module 0x632e40ff24025ce2d1d6bfbeda94d0d210ef0bcc0beff451919f68e862844c8::mcat {
    struct MCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCAT>(arg0, 6, b"MCAT", b"Morning Cat", b"Morning? Again? I swear, if one more sunbeam touches me...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/morning_cat_logo_ok_f5462f5178.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

