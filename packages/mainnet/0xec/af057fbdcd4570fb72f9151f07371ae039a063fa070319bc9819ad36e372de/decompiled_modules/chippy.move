module 0xecaf057fbdcd4570fb72f9151f07371ae039a063fa070319bc9819ad36e372de::chippy {
    struct CHIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPPY>(arg0, 6, b"CHIPPY", b"SUI CHIPPY", x"4845592c204d59204e414d45204953204348495050592e20494d204120444547454e455241544520424f4e4720534d4f4b494e472c20484f452050494d50494e472c204c414d424f2044524956494e4720434849504d554e4b2054484154204c4f56455320544f204d554e4348204f4e204e5554532e204c4554204d4520544153544520594f5552204e55545a2046414d2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000041907_a3b387c4e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

