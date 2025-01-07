module 0x60ea879a302e4bc37d3894784641efe6c610e881e959b9dce825a6f645777dac::akd {
    struct AKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKD>(arg0, 6, b"AKd", b"Alkaid", b"A frog wearing a crown, looking up at the stars in the sky, commemorating the history of the cryptocurrency market crash on December 20th.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_97fb5cf1_bfb4_4d1e_a686_524b7cd0506a_5b861aee50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

