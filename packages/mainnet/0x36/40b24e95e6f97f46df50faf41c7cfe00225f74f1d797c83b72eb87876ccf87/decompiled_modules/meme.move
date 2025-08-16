module 0x3640b24e95e6f97f46df50faf41c7cfe00225f74f1d797c83b72eb87876ccf87::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[b"MEME", b"Meme Coin", b"Just a meme coin", b"https://memez.gg"];
        let v1 = vector[b"MEME", b"Meme Coin", b"Just a meme coin", b"https://memez.gg"];
        let v2 = vector[b"MEME", b"Meme Coin", b"Just a meme coin", b"https://memez.gg"];
        let v3 = vector[b"MEME", b"Meme Coin", b"Just a meme coin", b"https://memez.gg"];
        let (v4, v5) = 0x2::coin::create_currency<MEME>(arg0, 9, *0x1::vector::borrow<vector<u8>>(&v0, 0), *0x1::vector::borrow<vector<u8>>(&v1, 1), *0x1::vector::borrow<vector<u8>>(&v2, 2), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&v3, 3))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME>>(v5);
    }

    // decompiled from Move bytecode v6
}

