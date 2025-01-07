module 0xcdd20f659117a9d19b8af19ad125a559430147b97fb91485c54d00c32a002023::burnt {
    struct BURNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNT>(arg0, 6, b"BURNT", b"BurntSuiInu", b"Burnt - The Meme Coin with a Fiery Twist! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002095_0042c3c08b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

