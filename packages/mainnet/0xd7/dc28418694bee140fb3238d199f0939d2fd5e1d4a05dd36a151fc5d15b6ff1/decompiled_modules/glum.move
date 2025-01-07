module 0xd7dc28418694bee140fb3238d199f0939d2fd5e1d4a05dd36a151fc5d15b6ff1::glum {
    struct GLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUM>(arg0, 6, b"GLUM", b"Glum", b"In the darkest depths of the SUI sea, where sunlight never dared to venture, lived an anglerfish named Glum.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015810_9b61627baf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

