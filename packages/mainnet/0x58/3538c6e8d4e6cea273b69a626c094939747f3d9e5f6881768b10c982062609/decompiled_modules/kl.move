module 0x583538c6e8d4e6cea273b69a626c094939747f3d9e5f6881768b10c982062609::kl {
    struct KL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KL>(arg0, 6, b"KL", b"KILLA", b"Killa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifet3bat7s4x4dt5r23gn5cbbidaonkoog3mfyhsbo3ni7w6x76fu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

