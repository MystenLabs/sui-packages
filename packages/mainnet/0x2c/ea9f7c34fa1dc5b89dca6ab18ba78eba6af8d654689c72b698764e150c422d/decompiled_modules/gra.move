module 0x2cea9f7c34fa1dc5b89dca6ab18ba78eba6af8d654689c72b698764e150c422d::gra {
    struct GRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRA>(arg0, 6, b"GRA", b"GraFun", b"Let's GraFun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/BK_Fs_Warw_400x400_2c4016f07d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

