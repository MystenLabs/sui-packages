module 0x2609f73cda11f4b6905c8c0a3e27ac65f20d93ce54748d20e16f6e77a2723d22::dgn {
    struct DGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGN>(arg0, 6, b"DGN", b"degen", x"6f6e6c7920646567656e200a757020746f20796f752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiad253jglh26oi3mo4auyhaispcmhyk4kyqd737tpiyeddugqqfum")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DGN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

