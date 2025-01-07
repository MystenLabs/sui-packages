module 0x97e481960cfb902761b47cd2e0b090251e83c050f3d266ad5bdb1ae2f164b6f0::naughty {
    struct NAUGHTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAUGHTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAUGHTY>(arg0, 9, b"naughty", b"naughty", b"really naughty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.svgrepo.com/show/535118/accessibility.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAUGHTY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAUGHTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAUGHTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

