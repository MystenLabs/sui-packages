module 0xc24972ccbfd89b831a370c881ba6028d96e9e2b10050cb605f9700598b5eaf10::sbh {
    struct SBH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBH>(arg0, 6, b"sBh", b"Sui Blackhole", b"Fucking black hole ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6279_3f49b00da2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBH>>(v1);
    }

    // decompiled from Move bytecode v6
}

