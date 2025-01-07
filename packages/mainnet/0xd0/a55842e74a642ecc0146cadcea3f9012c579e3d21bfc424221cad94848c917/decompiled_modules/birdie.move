module 0xd0a55842e74a642ecc0146cadcea3f9012c579e3d21bfc424221cad94848c917::birdie {
    struct BIRDIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDIE>(arg0, 6, b"BIRDIE", b"Sui Birdie", b"Yes, Im a legless bird and Im a fukin nerd. What turns me on is buys of 100+ SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_10_T175747_913_c7621ab388.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

