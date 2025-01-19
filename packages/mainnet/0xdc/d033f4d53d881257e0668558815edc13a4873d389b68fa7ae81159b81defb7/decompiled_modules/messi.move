module 0xdcd033f4d53d881257e0668558815edc13a4873d389b68fa7ae81159b81defb7::messi {
    struct MESSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSI>(arg0, 6, b"MESSI", b"OFFICIAL MESSI MEME", b"$MESSI - The only Official Lionel Messi meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_adbad6a141.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

