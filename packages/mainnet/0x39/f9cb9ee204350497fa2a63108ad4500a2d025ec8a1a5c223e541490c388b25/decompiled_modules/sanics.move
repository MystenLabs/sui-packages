module 0x39f9cb9ee204350497fa2a63108ad4500a2d025ec8a1a5c223e541490c388b25::sanics {
    struct SANICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANICS>(arg0, 6, b"SANICS", b"Sanic Coin On Sui", b"First Sanic Coin on Sui: https://www.saniccoinsui.pro.Dexscreener Paid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_18_325f4a4ae8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

