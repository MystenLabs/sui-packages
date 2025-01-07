module 0x9f2fbb3e15528e8af2d740b1bc1785632514419e8881243e3cdae54cf5a9cb3b::mefi {
    struct MEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEFI>(arg0, 6, b"MEFI", b"MeemFi", b"MeemFi is here to redefine the meme coin game!  Built for laughs, gains, and an unstoppable community, #MeemFi is the next big thing on the block", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/octo_d27e5b7569.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

