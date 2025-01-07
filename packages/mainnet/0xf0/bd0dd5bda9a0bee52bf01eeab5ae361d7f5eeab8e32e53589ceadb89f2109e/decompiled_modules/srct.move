module 0xf0bd0dd5bda9a0bee52bf01eeab5ae361d7f5eeab8e32e53589ceadb89f2109e::srct {
    struct SRCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRCT>(arg0, 6, b"SRCT", b"Starcat SUI", x"43617427732066726f6d207468652073746172732c206d6967687420616c726561647920626520737061636520647573742c20796f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meo_d795e92a9e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

