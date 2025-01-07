module 0x865649ddb1a01454016f41e19a014d28a9dffe84c13e0a6bb3649ae0bab2d950::oggie {
    struct OGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGIE>(arg0, 6, b"OGGIE", b"Oggie On Sui", b"Dexscreener Paid: oggieonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo2_537502dcc8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

