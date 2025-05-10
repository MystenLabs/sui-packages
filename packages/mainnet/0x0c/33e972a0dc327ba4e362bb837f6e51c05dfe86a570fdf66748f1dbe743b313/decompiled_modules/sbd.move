module 0xc33e972a0dc327ba4e362bb837f6e51c05dfe86a570fdf66748f1dbe743b313::sbd {
    struct SBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBD>(arg0, 6, b"SBD", b"Sui Booster DAO", b"Sui booster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiem3u4unznpzhlsza52muaahfyrrjuuwguktq4aotjt6xxiprlc5m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

