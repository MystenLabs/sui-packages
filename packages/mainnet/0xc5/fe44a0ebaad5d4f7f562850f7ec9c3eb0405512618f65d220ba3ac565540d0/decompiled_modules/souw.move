module 0xc5fe44a0ebaad5d4f7f562850f7ec9c3eb0405512618f65d220ba3ac565540d0::souw {
    struct SOUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUW>(arg0, 6, b"SOUW", b"SUI On UTYA", b"$SUI  isn't just another memecoin. It's a movement driven by community, spreading joy and positivity through the iconic Duck Emoji. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suita_51707e19f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOUW>>(v1);
    }

    // decompiled from Move bytecode v6
}

