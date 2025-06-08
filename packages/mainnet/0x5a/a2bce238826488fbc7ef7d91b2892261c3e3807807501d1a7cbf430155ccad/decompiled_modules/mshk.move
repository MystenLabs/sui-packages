module 0x5aa2bce238826488fbc7ef7d91b2892261c3e3807807501d1a7cbf430155ccad::mshk {
    struct MSHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSHK>(arg0, 6, b"MSHK", b"mishuk", b"pop mishuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiemnade5vieiv6to6svtszoaq7bzfndac3wmkbhd5d6qbqlmg727i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MSHK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

