module 0xb26fc0ff7835e9e0c867bf16defbe9024de459c5688e3cd7a4cce40aa46e41bc::trust {
    struct TRUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUST>(arg0, 6, b"TRUST", b"We must trust $SUI", b"Be strong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwzvr3rokat67h42vov6bb3o5tad473rbuvy5lgl7ozt56yzhaem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

