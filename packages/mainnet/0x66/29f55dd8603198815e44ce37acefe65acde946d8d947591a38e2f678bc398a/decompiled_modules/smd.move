module 0x6629f55dd8603198815e44ce37acefe65acde946d8d947591a38e2f678bc398a::smd {
    struct SMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMD>(arg0, 6, b"SMD", b"Seal Moo Deng", b"Just Seal Moo Deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_20_fceb790ded.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

