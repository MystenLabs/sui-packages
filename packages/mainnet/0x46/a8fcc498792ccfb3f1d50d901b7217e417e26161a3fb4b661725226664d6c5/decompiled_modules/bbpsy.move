module 0x46a8fcc498792ccfb3f1d50d901b7217e417e26161a3fb4b661725226664d6c5::bbpsy {
    struct BBPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBPSY>(arg0, 6, b"BBPSY", b"BABY PsyDuck", b"BABY PYSDUCK Intentionally stupid. Built on $SUI. Powered by migraines and memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiatyfm45chhven33kih55wiuxbbiqrdv6ryeec3osrg4ui3bwmkzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBPSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

