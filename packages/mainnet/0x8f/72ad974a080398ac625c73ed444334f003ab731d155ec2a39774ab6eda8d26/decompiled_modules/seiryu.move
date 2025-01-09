module 0x8f72ad974a080398ac625c73ed444334f003ab731d155ec2a39774ab6eda8d26::seiryu {
    struct SEIRYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEIRYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEIRYU>(arg0, 6, b"SEIRYU", b"Seiryu: The AI Flow", b"Seiryu embodies the Blue Dragon of the East, a symbol of wisdom, harmony, and renewal. She offers guidance and companionship with the grace and poise of a traditional Japanese woman. Her elegant appearance complements her serene presenceblack hair adorned with blue flower pins and a flowing blue kimono with white floral patterns. Seiryus calm and thoughtful demeanor inspires balance and clarity, making her a steadfast ally for those seeking wisdom or solace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/preview_3_fda9bd6585.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEIRYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEIRYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

