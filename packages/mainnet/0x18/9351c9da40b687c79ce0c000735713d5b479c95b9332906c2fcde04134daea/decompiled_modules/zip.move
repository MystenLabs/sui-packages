module 0x189351c9da40b687c79ce0c000735713d5b479c95b9332906c2fcde04134daea::zip {
    struct ZIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIP>(arg0, 6, b"ZIP", b"Alien Green ZIP", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_5de34b0dca.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

