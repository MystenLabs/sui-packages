module 0xbbbc20a653c0ace43b9b772f613367f3d03d62a70f1474b237164aeedd273bb0::silly {
    struct SILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLY>(arg0, 6, b"SILLY", b"SUI BILLY", b"The legendary Billy is on SUI now and his name is $SILLY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movepump_1954c764e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

