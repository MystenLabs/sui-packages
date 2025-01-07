module 0x51f082ddc31c53cd59e4bdcd9d6a98ed334c2b460c4673e30623dbe3bf2ee2a5::ivy {
    struct IVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVY>(arg0, 6, b"IVY", b"Sui Ivy", b"Im a Maltese dwog in a world ful of kats. Mi bigest insecuritii is I cant spelll, but fukit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_02_T205131_907_0784e41d6f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

