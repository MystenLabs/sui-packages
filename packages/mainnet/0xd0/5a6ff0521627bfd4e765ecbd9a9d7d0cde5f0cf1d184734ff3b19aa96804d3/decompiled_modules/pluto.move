module 0xd05a6ff0521627bfd4e765ecbd9a9d7d0cde5f0cf1d184734ff3b19aa96804d3::pluto {
    struct PLUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUTO>(arg0, 6, b"Pluto", b"Gangster Pluto", b"Pluto is an American cartoon character created by the Walt Disney Company. He is a yellow-orange color, medium-sized, short-haired dog with black ears. Unlike most Disney characters, Pluto is not anthropomorphic beyond some characteristics such as fa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735050128820.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLUTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

