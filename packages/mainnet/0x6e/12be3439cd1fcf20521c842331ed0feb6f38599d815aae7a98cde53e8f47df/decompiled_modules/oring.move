module 0x6e12be3439cd1fcf20521c842331ed0feb6f38599d815aae7a98cde53e8f47df::oring {
    struct ORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORING>(arg0, 11, b"ORING", b"ONE RING", b"One Ring to rule them all, One Ring to find them, One Ring to bring them all, and in the darkness bind them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/Jh75JSI.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ORING>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORING>>(v1);
    }

    // decompiled from Move bytecode v6
}

