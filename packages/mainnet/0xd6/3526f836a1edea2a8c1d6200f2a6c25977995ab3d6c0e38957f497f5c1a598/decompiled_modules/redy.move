module 0xd63526f836a1edea2a8c1d6200f2a6c25977995ab3d6c0e38957f497f5c1a598::redy {
    struct REDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDY>(arg0, 6, b"REDY", b"Sui Redy", b"Redy - Your sweet gateway to the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001075_c3db4cf99a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

