module 0xc48c8276fba4d0fa499f0540c786f4fa88d74c41f088f47bdae86bfcbc9f4a6f::badman {
    struct BADMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADMAN>(arg0, 6, b"BADMAN", b"Badman On Sui", b"Badman is on a mission to unite creatives and OGs, fueling art, memes, and mayhem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015604_b5e4541889.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

