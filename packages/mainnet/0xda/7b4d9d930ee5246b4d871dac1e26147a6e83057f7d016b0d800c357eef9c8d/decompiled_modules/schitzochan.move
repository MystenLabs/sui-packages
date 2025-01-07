module 0xda7b4d9d930ee5246b4d871dac1e26147a6e83057f7d016b0d800c357eef9c8d::schitzochan {
    struct SCHITZOCHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHITZOCHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHITZOCHAN>(arg0, 6, b"SchitzoChan", b"Schitzo-Chan", b"Yes anon I an 100% real.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5319_3f9b97ad3d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHITZOCHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHITZOCHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

