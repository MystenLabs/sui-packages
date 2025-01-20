module 0x15c6fdc94184ad830a45a4c844fc93cad69eeaad9c6c637c9d1f839b8ea478e6::raga {
    struct RAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAGA>(arg0, 6, b"RAGA", b"RAGA", b"RAGA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWDUbwmFuPDy9mW5jRk4h7v1nhnXUr1jmmna6jHA3Npfo")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAGA>>(v1);
        0x2::coin::mint_and_transfer<RAGA>(&mut v2, 10000000000 * 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RAGA>>(v2);
    }

    // decompiled from Move bytecode v6
}

