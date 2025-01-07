module 0x4a5a51244ba871fe5469199fcd83d26f6efdeb9b4d61d47bbc518fa5857d5600::ew {
    struct EW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EW>(arg0, 6, b"EW", b"Ewwww", b"Has been and will always be a MEME.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000294240_cac1ba7260.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EW>>(v1);
    }

    // decompiled from Move bytecode v6
}

