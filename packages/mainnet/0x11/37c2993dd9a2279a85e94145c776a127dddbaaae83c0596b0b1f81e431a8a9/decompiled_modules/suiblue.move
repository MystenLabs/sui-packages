module 0x1137c2993dd9a2279a85e94145c776a127dddbaaae83c0596b0b1f81e431a8a9::suiblue {
    struct SUIBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBLUE>(arg0, 9, b"SUIBLUE", b"SUIBLUE", b"Sui and blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBLUE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLUE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

