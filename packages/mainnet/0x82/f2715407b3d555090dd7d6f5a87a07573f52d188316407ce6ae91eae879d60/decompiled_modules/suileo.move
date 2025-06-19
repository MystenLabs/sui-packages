module 0x82f2715407b3d555090dd7d6f5a87a07573f52d188316407ce6ae91eae879d60::suileo {
    struct SUILEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEO>(arg0, 6, b"SUILEO", b"SUIALEO", b"Suialeo live on top of drift ice. They go swimming when they're on the hunt, seeking out their prey by scent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bloggif_68535268a512f_d0e9b6d82c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

