module 0x6035b741b323392e0dc8299fac1b683d6b3ee73cbb195ab56e7fc44521138f70::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 6, b"MOJO", b"MOJO ON SUI", b"Mojo is more than just a characte it's a red-hot memecoin born from the first-ever illustration by Matt Furie in 1985, when he was just a kid. Each blockchain has its own iconic Furie creation, and now SUI has $MOJO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731426937529.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOJO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

