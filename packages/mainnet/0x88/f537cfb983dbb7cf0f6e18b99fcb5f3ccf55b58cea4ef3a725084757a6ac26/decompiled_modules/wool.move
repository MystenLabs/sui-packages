module 0x88f537cfb983dbb7cf0f6e18b99fcb5f3ccf55b58cea4ef3a725084757a6ac26::wool {
    struct WOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOL>(arg0, 6, b"WOOL", b"woolSUI", b"my pronouns are wo/ol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241130_225601_975_348d50c359.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

