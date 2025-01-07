module 0xdf7c427e41fbc135532c2666bbb61665f0679dfad1b213ef8bc670fa3c2af509::lady {
    struct LADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADY>(arg0, 6, b"LADY", b"Lady Dolphin", b"aint she perty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uo_DAMNQY_400x400_be2a7a5f58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

