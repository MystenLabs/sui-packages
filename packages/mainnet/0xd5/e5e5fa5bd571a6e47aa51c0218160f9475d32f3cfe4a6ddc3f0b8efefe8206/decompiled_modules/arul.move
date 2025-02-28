module 0xd5e5e5fa5bd571a6e47aa51c0218160f9475d32f3cfe4a6ddc3f0b8efefe8206::arul {
    struct ARUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARUL>(arg0, 9, b"ARUL", b"ArulCoin", b"A new token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARUL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARUL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

