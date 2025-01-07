module 0x8eb5598876e13e956f0300465b56bea0b73a040f6af33b1dc62c4f8e8f80854b::fishbone {
    struct FISHBONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHBONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHBONE>(arg0, 6, b"Fishbone", b"FishBone", b"Ready to Fish? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_Artwork_a28f8cbfb0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHBONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHBONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

