module 0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::msx {
    struct MSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSX>(arg0, 6, b"MSX", b"MSX Coin", b"Moviepass Stock Exchange Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/5CWRcYw.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

