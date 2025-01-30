module 0x6a835d646438268b621cbc9fed9313a90e28ff09e70ebf0d7b81d02a6051f14b::trim {
    struct TRIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIM>(arg0, 9, b"TRIM", b"TRIM ON SUI", b"that's $TRIM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNoAk4qQihkGtnDZ6dyecPd8iZvXomWsA9jARkUVEgjrX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRIM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

