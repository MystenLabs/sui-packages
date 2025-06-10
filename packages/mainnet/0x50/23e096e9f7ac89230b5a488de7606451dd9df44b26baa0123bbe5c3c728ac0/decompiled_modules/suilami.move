module 0x5023e096e9f7ac89230b5a488de7606451dd9df44b26baa0123bbe5c3c728ac0::suilami {
    struct SUILAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMI>(arg0, 6, b"SUILAMI", b"Marsuilami", b"The original mascot $SUILAMI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicwzzythhxpvuz2bqs227xvue3jsrymzyu4lilppfqgzplct5c6f4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILAMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

