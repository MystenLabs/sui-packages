module 0x5e15380d42fd07d1ebf75a2fb4466072c5ac67b9aafa7b8cab4a7b28bd6d257e::sealp {
    struct SEALP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALP>(arg0, 6, b"SEALP", b"Seal Pnut Sui", b"From Ocean Depths to Moon Heights: The Sealpnut Story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_6f035b60_6e0b_48fd_a293_d7dc509be7dd_98fd63bb17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALP>>(v1);
    }

    // decompiled from Move bytecode v6
}

