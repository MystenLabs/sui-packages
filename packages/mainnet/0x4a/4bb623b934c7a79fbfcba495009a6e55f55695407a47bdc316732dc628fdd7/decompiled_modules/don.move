module 0x4a4bb623b934c7a79fbfcba495009a6e55f55695407a47bdc316732dc628fdd7::don {
    struct DON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DON>(arg0, 6, b"DON", b"POSUIDON", b"I'm Posuidon, not to be confused with Poseidon, who's probably off fishing for SUI tokens . I'm the king of the SUI chain, not the Sea chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidon_pfp_c386b90eec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DON>>(v1);
    }

    // decompiled from Move bytecode v6
}

