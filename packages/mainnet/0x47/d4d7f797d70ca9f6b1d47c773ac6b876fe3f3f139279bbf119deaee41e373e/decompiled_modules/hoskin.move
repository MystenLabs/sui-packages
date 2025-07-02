module 0x47d4d7f797d70ca9f6b1d47c773ac6b876fe3f3f139279bbf119deaee41e373e::hoskin {
    struct HOSKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOSKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOSKIN>(arg0, 6, b"HOSKIN", b"Andrew Hoskinberg", b"We are andrew one face infinite bergs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib53benzw6i7hqx7lzvojbgdb6dvovlkocuj2kc7pi7wrwdxihlbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOSKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOSKIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

