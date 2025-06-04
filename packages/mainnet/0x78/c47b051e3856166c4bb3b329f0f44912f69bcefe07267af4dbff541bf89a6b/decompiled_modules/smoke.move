module 0x78c47b051e3856166c4bb3b329f0f44912f69bcefe07267af4dbff541bf89a6b::smoke {
    struct SMOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKE>(arg0, 6, b"SMOKE", b"crabwifsmoke", b"Just a crab wif a smoke.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieqlz5z224mm4ng5woj7ju5xwgyx66gw52ehfazqtwbqccagchgem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMOKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

