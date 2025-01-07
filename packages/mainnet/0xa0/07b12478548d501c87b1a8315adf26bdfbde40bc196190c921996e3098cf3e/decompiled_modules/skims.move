module 0xa007b12478548d501c87b1a8315adf26bdfbde40bc196190c921996e3098cf3e::skims {
    struct SKIMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIMS>(arg0, 6, b"SKIMS", b"Skims", b"Welcome to $SKIMS! Exciting news - we've launched our own $SKIMS Sui token, bringing fashion and cryptocurrency together. As we continue to innovate, join us for an exclusive experience at the intersection of style and technology. Thanks for being part of the $SKIMS journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/skims_logo_21836d53ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

