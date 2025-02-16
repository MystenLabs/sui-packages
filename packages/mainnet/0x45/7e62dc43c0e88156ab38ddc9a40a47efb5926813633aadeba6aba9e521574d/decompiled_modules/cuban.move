module 0x457e62dc43c0e88156ab38ddc9a40a47efb5926813633aadeba6aba9e521574d::cuban {
    struct CUBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUBAN>(arg0, 9, b"CUBAN", b"OFFICIAL CUBAN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQzCPW5k4woYSR6cmPYbomzQJ3CPRTY5WjCnVLYrEyf6n")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CUBAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUBAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUBAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

