module 0x673703a50ea09bb516c03693c303c7d609e28e63b0c5577323c8627959be4ce4::catgf {
    struct CATGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGF>(arg0, 6, b"CATGF", b"Cat girl friend", b"With her soft, flowing hair and a gentle, wistful expression, she gazes thoughtfully into the distance, evoking a sense of quiet longing. Subtle warm light filters through the window, casting a peaceful glow around her. In the background, a small cat house sits with a cute white cat, hinting at the girls deep desire for companionship. The overall tone of the image is calm and reflective, blending natural tones with soft blues, creating a heartfelt and emotionally rich atmosphere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FDCB_0803_E3_A1_427_B_AE_63_E4383_B318948_1c4cdcf03f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

