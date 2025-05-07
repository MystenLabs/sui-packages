module 0x1745442b2d026ad90054a5b186372a3529cc780f43e2d50b8ed887f08bc1f4a2::russo {
    struct RUSSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSO>(arg0, 6, b"RUSSO", b"Russo on SUI", b"Sui's chosen Walrus divine messenger, Russo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigxwpvuiw7h3aw7stozgrpozfsmqpecow5qc5uj2sfshun67dwqs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUSSO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

