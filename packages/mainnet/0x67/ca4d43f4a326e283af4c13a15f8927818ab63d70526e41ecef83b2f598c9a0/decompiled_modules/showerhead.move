module 0x67ca4d43f4a326e283af4c13a15f8927818ab63d70526e41ecef83b2f598c9a0::showerhead {
    struct SHOWERHEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOWERHEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOWERHEAD>(arg0, 6, b"SHOWERHEAD", b"Shower  Head", b"Time to wash away the FUD! Shower Head is the fresh meme token that rinses off the noise and keeps things flowing on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shower_Head_780b60b527.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOWERHEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOWERHEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

