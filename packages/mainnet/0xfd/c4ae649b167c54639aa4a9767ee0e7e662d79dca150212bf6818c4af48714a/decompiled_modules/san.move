module 0xfdc4ae649b167c54639aa4a9767ee0e7e662d79dca150212bf6818c4af48714a::san {
    struct SAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAN>(arg0, 9, b"San", b"San Chan", b"San Chan is a Kawaii shiba walking across Japan with her papa Kanatro  !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWDv4SzGZ6qJDSEtRFS9wKCcR8eiS27iQ8nFcL5McdpuW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

