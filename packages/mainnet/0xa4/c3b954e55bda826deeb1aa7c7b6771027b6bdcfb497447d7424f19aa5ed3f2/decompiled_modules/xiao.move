module 0xa4c3b954e55bda826deeb1aa7c7b6771027b6bdcfb497447d7424f19aa5ed3f2::xiao {
    struct XIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAO>(arg0, 6, b"Xiao", b"Xiaopang", b"Xiaopang, the Chinese dog (), has recently been gaining significant attention on social media, particularly on Douyin (), the Chinese version of TikTok. Hilarious and playful videos featuring Xiaopang have captured the hearts of viewers, showcasing moments where his owners humorously tease him for mischief he didnt commit or catch him red-handed stealing roasted duck from the kitchen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7425_df379f88c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

