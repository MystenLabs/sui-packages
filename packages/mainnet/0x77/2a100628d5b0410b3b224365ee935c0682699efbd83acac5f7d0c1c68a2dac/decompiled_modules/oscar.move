module 0x772a100628d5b0410b3b224365ee935c0682699efbd83acac5f7d0c1c68a2dac::oscar {
    struct OSCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSCAR>(arg0, 6, b"OSCAR", b"Justin Bieber Dog", b"Oscar is Justin Bieber's adorable dog, known for stealing the spotlight on social media. This furry companion often accompanies Bieber on his adventures and has become a beloved part of the pop star's life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240923_144912_408_fb416ee35d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

