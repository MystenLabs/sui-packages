module 0xa69dad56f25fb8a8b1cac5515a129da936474609239673aeb1e5719bbe3e7cfa::bows {
    struct BOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOWS>(arg0, 6, b"BOWS", b"Book of Wall Street on Sui", b"Dexscreener Paid.Welcome to Book Of Wall Street : https://www.bookofwallstreetonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_24_dcc98f7d14.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

