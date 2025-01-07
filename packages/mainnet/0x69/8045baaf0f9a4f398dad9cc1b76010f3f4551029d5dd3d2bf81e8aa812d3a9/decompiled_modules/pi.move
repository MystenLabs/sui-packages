module 0x698045baaf0f9a4f398dad9cc1b76010f3f4551029d5dd3d2bf81e8aa812d3a9::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 6, b"Pi", b"Pi Network", b"Build the worlds most inclusive peer-to-peer ecosystem and online experience, fueled by Pi, the worlds most widely used cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_f7832cabf6.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PI>>(v1);
    }

    // decompiled from Move bytecode v6
}

