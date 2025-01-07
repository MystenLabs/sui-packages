module 0x47f32ce50a6d7b33320a3d7ba2c03c09a10a60cfe5e2395829b41093529f9244::kemdn {
    struct KEMDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEMDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEMDN>(arg0, 9, b"KEMDN", b"iejdn", b"jdne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed748a5b-b975-4570-a4b1-fe4aa71bd634.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEMDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEMDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

