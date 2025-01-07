module 0x3b4fb72df3462b83a064c87db54f782e6dda1c0f3edac7f1c2441c32023fcc78::gator {
    struct GATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATOR>(arg0, 6, b"GATOR", b"ALLISTER GATOR", b"https://x.com/mobgamesstudios/status/1842248367583195385", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/124234123123_681bf85d77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

