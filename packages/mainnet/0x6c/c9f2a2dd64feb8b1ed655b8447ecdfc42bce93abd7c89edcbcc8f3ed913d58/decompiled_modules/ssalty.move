module 0x6cc9f2a2dd64feb8b1ed655b8447ecdfc42bce93abd7c89edcbcc8f3ed913d58::ssalty {
    struct SSALTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSALTY>(arg0, 9, b"ssalty", b"Sui Salty", b"SSALTY IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fa_cute_meme_of_sea_s_732ef0a397_d31f46aa7f.webp&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSALTY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSALTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSALTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

