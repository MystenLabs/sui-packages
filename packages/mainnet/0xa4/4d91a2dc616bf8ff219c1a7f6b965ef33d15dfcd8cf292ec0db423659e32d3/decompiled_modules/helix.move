module 0xa44d91a2dc616bf8ff219c1a7f6b965ef33d15dfcd8cf292ec0db423659e32d3::helix {
    struct HELIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELIX>(arg0, 6, b"HELIX", b"HELIX WHEELS THE TORTOISE", b"Helix was born with spinal deformity. He couldnt use his back legs. Then he got wheels. Helix is a famous Instagram tortoise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4600_cf7b1a7a7e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

