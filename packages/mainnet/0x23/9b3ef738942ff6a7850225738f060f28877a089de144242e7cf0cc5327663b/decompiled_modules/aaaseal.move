module 0x239b3ef738942ff6a7850225738f060f28877a089de144242e7cf0cc5327663b::aaaseal {
    struct AAASEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASEAL>(arg0, 6, b"AAASEAL", b"aaaseal", b"Can't stop won't stop thinking about eating fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaseal_eb459673c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

