module 0x105739c7bfb63e9863de8926a463bfa89e70e7bfacf53fa05eac9a07f684e19f::ikas {
    struct IKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKAS>(arg0, 6, b"IKAs", b"IKA on Sui", b" IKA is the meme coin Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/obxk_M0_Ch_400x400_dd1a80238b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

