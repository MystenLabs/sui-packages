module 0xdef3f72d724debfbd974c5deb49cac2ce9eb9ceff4619f5e9e90f9793f1aa308::krik {
    struct KRIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIK>(arg0, 6, b"KRIK", b"Charlie Kirk", b"Justice For Kirk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibjzv2sixueyrsn5vxheib3zhhe7d7egnp6pbmf2jeyt76wwanvay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRIK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

