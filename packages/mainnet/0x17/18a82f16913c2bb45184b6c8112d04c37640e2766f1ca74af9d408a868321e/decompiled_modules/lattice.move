module 0x1718a82f16913c2bb45184b6c8112d04c37640e2766f1ca74af9d408a868321e::lattice {
    struct LATTICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LATTICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LATTICE>(arg0, 6, b"Lattice", b"Lattice Agent", b"Lattice Agent Model 1 Gemini", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeicgbij2kugltz2h75xfi7gy5zxxe72wl7ysbztaeebes4dag2vhge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LATTICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LATTICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

