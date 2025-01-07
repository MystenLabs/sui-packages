module 0x44632f29b93fa7c61525f4f33e1ffa763586c160f1c8b656909a6bcdbcf54b8b::mhub {
    struct MHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHUB>(arg0, 6, b"MHUB", b"First Meme Hub On Sui", b"Dexscreener Paid.Check here: https://www.memehubcoinonsui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_1ac4013ab8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

