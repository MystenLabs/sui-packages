module 0x6a630d6b1813873bc27f6a88541f53a93ce5474ed34a10d6b05308e149390467::bobscope {
    struct BOBSCOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBSCOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBSCOPE>(arg0, 6, b"BobScope", b"BOB", b"Visionary Weirdo ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dream_3_0747a76714.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBSCOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBSCOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

