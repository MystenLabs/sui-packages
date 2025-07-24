module 0x531e3a6c0324f0ce7d631efbafb72f8bc8af94e9d7359caf8818357e2ae9e39b::pyt {
    struct PYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYT>(arg0, 6, b"PYT", b"PLAYTRON token", b"The Operating System for Games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicmjrcvx5dbmvmx7fgnmju6gzfiwxor37yicpjjinykoszfsflpua")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PYT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

