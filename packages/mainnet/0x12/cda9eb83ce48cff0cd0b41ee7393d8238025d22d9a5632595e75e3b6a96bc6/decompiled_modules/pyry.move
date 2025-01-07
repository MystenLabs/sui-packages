module 0x12cda9eb83ce48cff0cd0b41ee7393d8238025d22d9a5632595e75e3b6a96bc6::pyry {
    struct PYRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYRY>(arg0, 6, b"PYRY", b"PYRY SUI", b"Pyry is innivative memecoin based on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x5408d3883ec28c2de205064ae9690142b035fed2_969ac366ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PYRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

