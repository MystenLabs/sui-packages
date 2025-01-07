module 0x98ea3a4d1f70f56e35d4f75a19e91998c1fb14916ef7a62e993918cbaca8e86c::marsh {
    struct MARSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARSH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MARSH>(arg0, 6, b"MARSH", x"4d61727368616c6c2053c3a1206279205375694149", b"His presence is like hearing a melody crafted by a violin graceful yet captivating, stirring emotions with every note. His energy is contagious, but there's something in his eyes a mysterious glow, a restless calm that makes you question whether he's as transparent as he appears to be..Marshall enjoys the game but never reveals all his cards, choosing instead to leave a trail of intrigue and curiosity wherever he goes..With Marshall, nothing is predictable. He moves effortlessly between light and shadow, playful and irreverent, as if daring everyone to match his rhythm though few can. If you cross paths with him, be prepared: he is not just a presence; he's an experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Marhall_Sa_80f68eab15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MARSH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

