module 0x629fb28f73a5b572c0ad74e30ce163b1aaa307ff7c8ea505c910ce64d6e90b67::apu {
    struct APU has drop {
        dummy_field: bool,
    }

    fun init(arg0: APU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APU>(arg0, 6, b"APU", b"Apu Apustaja 2.0", b"Apu is a memecoin built on the iconic Apu Apustaja (\"Help Helper\") meme - the younger, sweeter version of the iconic frog Pepe, with big dreams and an even bigger heart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_3fea54a1d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APU>>(v1);
    }

    // decompiled from Move bytecode v6
}

