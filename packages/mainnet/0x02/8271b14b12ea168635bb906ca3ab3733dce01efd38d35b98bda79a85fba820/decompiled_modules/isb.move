module 0x28271b14b12ea168635bb906ca3ab3733dce01efd38d35b98bda79a85fba820::isb {
    struct ISB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISB>(arg0, 6, b"ISB", b"Ichi sui boss", b"Ichhi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidgjt3jxxnxk5r6ditg2w4ng763qvjsvhbhi7z3ctuqxvs4z43br4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ISB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

