module 0x804406c34c358a14dc7ea3660345e366ee29e461f2b48c25898425ad34104d53::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACK>(arg0, 6, b"QUACK", b"DuckWifHeadset", b"Imagine a cheerful duck wearing a stylish headset, always grooving to its favorite tunes. This duck absolutely loves music and spreads joy wherever it goes, bringing fun and happiness to its loved ones. Whether its dancing to the beat or sharing its favorite songs, this duck knows how to make every moment special and filled with laughter. $QUACK QUACK now on SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010174_8e88e8cf4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

