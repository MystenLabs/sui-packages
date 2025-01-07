module 0x665c40ba5085d037202cdef9b5e49a711084081f34e228d82cc6a4309e9444cd::shroom {
    struct SHROOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHROOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHROOM>(arg0, 6, b"SHROOM", b"MUSHROOM JR", b"Mushroom JR is a whimsical meme coin that embodies the fun and playful side of the crypto world! Inspired by the quirky and colorful Mushroom JR character, this coin aims to cultivate a community driven by laughter, lightheartedness, and a dash of irreverence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mushroomjr_eedabd75eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHROOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHROOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

