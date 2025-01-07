module 0xd316fc807812ff9d5769c61c254d12e4fdf3e195e4f7704bc32df4f2b32f80e2::lazycat {
    struct LAZYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAZYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZYCAT>(arg0, 6, b"LAZYCAT", b"LazyCat", b"Venues for $LAZYCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9539_21953e0979.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAZYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

