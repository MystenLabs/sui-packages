module 0x3e7e73e12031e90a05ecc5af25215ff7bd722898abb9b99bea29f619f948f55f::tstold {
    struct TSTOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTOLD>(arg0, 6, b"TSTOLD", b"TSTOLD Token", b"This is a test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTOLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

