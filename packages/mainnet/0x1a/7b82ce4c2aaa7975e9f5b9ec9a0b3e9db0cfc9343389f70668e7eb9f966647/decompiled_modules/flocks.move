module 0x1a7b82ce4c2aaa7975e9f5b9ec9a0b3e9db0cfc9343389f70668e7eb9f966647::flocks {
    struct FLOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOCKS>(arg0, 6, b"FLOCKS", b"FLOCKS Revolutionary", b"$FLOCKS  is a groundbreaking meme platform Vote-To-Earn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t5g_HIGGU_400x400_be0762b3d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

