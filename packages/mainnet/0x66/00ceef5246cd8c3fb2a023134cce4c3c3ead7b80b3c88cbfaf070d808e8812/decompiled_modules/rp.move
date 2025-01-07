module 0x6600ceef5246cd8c3fb2a023134cce4c3c3ead7b80b3c88cbfaf070d808e8812::rp {
    struct RP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RP>(arg0, 6, b"RP", b"Red_Panda", b"red_panda is a new AI image generation model that's suddenly popped up and is crushing it - scoring about 12% better win-rates than the top AI models out there. Everyone's waiting to see who steps up to claim it, since it just appeared out of nowhere on leaderboard. Word is it might be a new Chinese text-to-image AI model or a new OpenAI model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c831d9675094c2acf4abde59785e8720_ddd68e9f94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RP>>(v1);
    }

    // decompiled from Move bytecode v6
}

