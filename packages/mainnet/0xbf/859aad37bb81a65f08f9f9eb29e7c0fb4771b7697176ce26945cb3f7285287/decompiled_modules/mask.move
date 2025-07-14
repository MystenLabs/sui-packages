module 0xbf859aad37bb81a65f08f9f9eb29e7c0fb4771b7697176ce26945cb3f7285287::mask {
    struct MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASK>(arg0, 6, b"MASK", b"catwifmask", b"catwifmask (MASK)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catwifmask_logo_3234d8edb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

