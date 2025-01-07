module 0x5480eac12938be26badcc1717f43796a220cfb8f7e3534c58dcf5c84ca4b2cbd::vfrog {
    struct VFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VFROG>(arg0, 6, b"VFROG", b"VAN FROG GOGH", b"A tribute to one of the greatest icons, the STARRY NIGHT by Van Gogh, this starry night frog will reach the sky ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_frog_3b47ca99fe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

