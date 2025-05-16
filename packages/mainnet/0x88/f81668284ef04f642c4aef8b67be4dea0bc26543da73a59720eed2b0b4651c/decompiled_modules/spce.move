module 0x88f81668284ef04f642c4aef8b67be4dea0bc26543da73a59720eed2b0b4651c::spce {
    struct SPCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPCE>(arg0, 6, b"SPCE", b"Sui Piece", b"From the Grand Line to the Sui seas...join the as they embark on their journey for the almighty Sui Piece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091594_8c1544287d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

