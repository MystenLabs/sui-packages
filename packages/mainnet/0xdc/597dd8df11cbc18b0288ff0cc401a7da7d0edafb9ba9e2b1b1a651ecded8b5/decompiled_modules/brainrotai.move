module 0xdc597dd8df11cbc18b0288ff0cc401a7da7d0edafb9ba9e2b1b1a651ecded8b5::brainrotai {
    struct BRAINROTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINROTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAINROTAI>(arg0, 6, b"BrainRotAI", b"Brain Rot AI", b"Innovation within the brain rot space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yh_DE_8l_EE_400x400_d1ef5779a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINROTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAINROTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

