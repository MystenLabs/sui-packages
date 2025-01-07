module 0xc32bb4bfd486c82a40aa127dcd200789ca98c3268c2c890f78936c72a5da638d::youyounext {
    struct YOUYOUNEXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUYOUNEXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUYOUNEXT>(arg0, 6, b"Youyounext", b"Whaazzui", b"I cover i cover i cover , you next you next you next ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2_547d099b27.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUYOUNEXT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOUYOUNEXT>>(v1);
    }

    // decompiled from Move bytecode v6
}

