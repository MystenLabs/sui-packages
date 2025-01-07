module 0x74f4ba724fc4a252b5e603cb846dab442b8750e44c38110a0207815aca3a80b::mwu {
    struct MWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWU>(arg0, 6, b"MWU", b"Meowlu", b"Careful! The moon is mine ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3463_66aa1240dc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

