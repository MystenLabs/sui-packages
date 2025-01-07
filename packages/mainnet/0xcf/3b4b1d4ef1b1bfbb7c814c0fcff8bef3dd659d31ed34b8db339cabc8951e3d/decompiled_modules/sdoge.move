module 0xcf3b4b1d4ef1b1bfbb7c814c0fcff8bef3dd659d31ed34b8db339cabc8951e3d::sdoge {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 6, b"SDOGE", b"DOGE", b"Bad liar. The last developer has been.Bad cheater The last developer has run away and we rebuild the dogThe last developer of the bad cheater has run away, we rebuild the dog, and the token ratio will not lead to a crash.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012767_63ab187271.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

