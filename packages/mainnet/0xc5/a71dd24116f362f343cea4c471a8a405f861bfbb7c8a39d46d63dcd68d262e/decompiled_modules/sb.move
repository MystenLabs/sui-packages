module 0xc5a71dd24116f362f343cea4c471a8a405f861bfbb7c8a39d46d63dcd68d262e::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 6, b"SB", b"suibitcoin", b"SUI WILL REPLACE BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_04_04_07_25_An_enhanced_version_of_the_previous_image_with_the_Sui_logo_inside_the_large_S_now_filled_with_a_sketch_like_pattern_of_the_word_Sui_in_a_repeatin_28efbbdf56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

