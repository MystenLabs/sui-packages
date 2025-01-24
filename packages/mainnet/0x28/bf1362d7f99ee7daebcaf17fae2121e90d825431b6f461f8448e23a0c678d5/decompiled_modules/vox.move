module 0x28bf1362d7f99ee7daebcaf17fae2121e90d825431b6f461f8448e23a0c678d5::vox {
    struct VOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOX>(arg0, 6, b"VOX", b"VOX", b"VOX ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1737714231908-VoxAI.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VOX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

