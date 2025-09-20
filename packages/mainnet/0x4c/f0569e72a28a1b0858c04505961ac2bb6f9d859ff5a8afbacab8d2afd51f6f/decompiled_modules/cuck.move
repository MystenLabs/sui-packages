module 0x4cf0569e72a28a1b0858c04505961ac2bb6f9d859ff5a8afbacab8d2afd51f6f::cuck {
    struct CUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCK>(arg0, 6, b"CUCK", b"Sui Cuck", b"OMG! Look how cute he is!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicpmtkrbbwvak5edp5li5dcsnz23ie2ywjn7gu4jo2seclerfevcm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

