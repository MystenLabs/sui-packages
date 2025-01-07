module 0x1489f7d4771fb80ae5b03764a838f836128553cb9ccf4fe8eeea2d05856895d9::halloween {
    struct HALLOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEEN>(arg0, 6, b"Halloween", b"Happy Halloween", b"Happy Halloween ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9796_jpg_wh300_04e104a43b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

