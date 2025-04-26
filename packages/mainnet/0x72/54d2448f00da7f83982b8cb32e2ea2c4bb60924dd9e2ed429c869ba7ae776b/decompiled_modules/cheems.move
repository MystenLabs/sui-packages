module 0x7254d2448f00da7f83982b8cb32e2ea2c4bb60924dd9e2ed429c869ba7ae776b::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 9, b"Cheems", b"Cheems Balltze", b"CHEEMS, BONK DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sapphire-working-koi-276.mypinata.cloud/ipfs/bafkreicx3ql44nqknvdevmw5dubioqvr3af7a6nidc5jckng3huszpdyyy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHEEMS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

