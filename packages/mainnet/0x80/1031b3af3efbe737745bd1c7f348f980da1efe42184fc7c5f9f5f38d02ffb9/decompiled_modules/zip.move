module 0x801031b3af3efbe737745bd1c7f348f980da1efe42184fc7c5f9f5f38d02ffb9::zip {
    struct ZIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIP>(arg0, 6, b"ZIP", b"ZIP Alien Green", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_9ca66e4c3c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

