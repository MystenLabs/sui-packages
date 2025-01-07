module 0xca7d2df3190c7a140fdd2fe525c4e770fac7cd46dc072ae8801d23570ad9fd4d::dognald {
    struct DOGNALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGNALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGNALD>(arg0, 6, b"DOGNALD", b"Official Dognald Trump On Sui", b"DOGNALD is the memecoin that will change the game, leading the crypto world to new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_4_53e7da2de5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGNALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGNALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

