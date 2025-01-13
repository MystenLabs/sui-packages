module 0xe3dbd3bd7ff8a5a0850e967f123bf6415e44f170117ec27cb55f1d1ef5d05e2d::mum {
    struct MUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUM>(arg0, 6, b"MUM", b"Max und Moritz", b"Max und Moritz was first published in 1865 and is considered one of the earliest and most iconic comic strips, inspiring generations of humor and creativity. Now, they're bringing their mischief to the SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1efe873286.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

