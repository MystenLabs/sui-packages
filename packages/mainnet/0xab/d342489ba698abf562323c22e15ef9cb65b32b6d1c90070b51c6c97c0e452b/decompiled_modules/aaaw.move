module 0xabd342489ba698abf562323c22e15ef9cb65b32b6d1c90070b51c6c97c0e452b::aaaw {
    struct AAAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAW>(arg0, 6, b"AAAW", b"ads", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidymp52yotl2v6pnp6uplmpiqkcmo3msotjz5yfm6bbrx3r7h5afu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAAW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

