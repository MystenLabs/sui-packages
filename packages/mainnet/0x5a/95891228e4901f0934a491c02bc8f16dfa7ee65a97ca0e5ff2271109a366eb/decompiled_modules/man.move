module 0x5a95891228e4901f0934a491c02bc8f16dfa7ee65a97ca0e5ff2271109a366eb::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 6, b"MAN", b"MAN", b"MANTV ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWDUbwmFuPDy9mW5jRk4h7v1nhnXUr1jmmna6jHA3Npfo")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAN>>(v1);
        0x2::coin::mint_and_transfer<MAN>(&mut v2, 10000000000 * 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAN>>(v2);
    }

    // decompiled from Move bytecode v6
}

