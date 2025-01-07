module 0xb2753f67ff114ab18879ad80795ba46199de97fe06cb43b4bba4f87cf24612d6::flupsi {
    struct FLUPSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUPSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUPSI>(arg0, 6, b"FLUPSI", b"SUI Flop", b"When your Sui meme coin portfolio flops harder than Flupsi himself!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flop_e9303a16b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUPSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUPSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

