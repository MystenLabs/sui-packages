module 0x11b0c9b146219f08884bebf3d8c7c8f6ad96a8d2416e3c2e1e174030c544d8a7::doom {
    struct DOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOM>(arg0, 6, b"DOOM", b"DoomScroll", b"$DOOMSCROLL is not just a token; it's a satirical dive into the abyss of internet addiction, meme culture, and the endless scrolling of meme tokens. Our mascot, a skull with glowing eyes, embodies the zombie-like trance of doomscrolling ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735974852751.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

