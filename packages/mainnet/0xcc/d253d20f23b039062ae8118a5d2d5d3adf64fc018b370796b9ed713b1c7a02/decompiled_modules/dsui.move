module 0xccd253d20f23b039062ae8118a5d2d5d3adf64fc018b370796b9ed713b1c7a02::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUI>(arg0, 6, b"DSUI", b"DOODIE SUI", x"45564552204845415244204f462046415254434f494e204f524947494e414c3f205448495320484153205355504552204641525420504f574552210a444f4f44494545204d414e4e4e4e4e2121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_05_28_010258_ff59a71c1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

