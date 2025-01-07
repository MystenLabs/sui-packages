module 0xbd3400fdc996634118a4261d110eb4088c3a64dfff05e28af80d2b006fd3dbb2::thirsty {
    struct THIRSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIRSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THIRSTY>(arg0, 6, b"THIRSTY", b"Thirsty", b"Feeling dry and dusty in the crypto desert? THIRSTY is the meme token oasis you've been crawling toward. Whether you're gulping down gains or just licking the glass for memes, THIRSTY On the Sui chain has that pure, unfiltered meme energy to keep your portfolio quenched.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_J0_Tdu_TZ_400x400_b5f1f8cb8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIRSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THIRSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

