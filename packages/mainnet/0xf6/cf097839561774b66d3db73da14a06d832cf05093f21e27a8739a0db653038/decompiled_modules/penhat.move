module 0xf6cf097839561774b66d3db73da14a06d832cf05093f21e27a8739a0db653038::penhat {
    struct PENHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENHAT>(arg0, 6, b"PENHAT", b"Penguin hat", b"This is a beloved character in the SUI ecosystem. Let's all show it some love and affection.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_25_17_16_05_A_pixel_art_of_a_cute_penguin_wearing_a_hat_focusing_on_its_upper_body_The_penguin_has_a_rounded_face_with_large_eyes_and_a_small_beak_The_hat_is_9b0c904f14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

