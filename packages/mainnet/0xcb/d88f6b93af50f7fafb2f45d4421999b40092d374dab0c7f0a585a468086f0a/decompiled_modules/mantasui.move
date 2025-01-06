module 0xcbd88f6b93af50f7fafb2f45d4421999b40092d374dab0c7f0a585a468086f0a::mantasui {
    struct MANTASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTASUI>(arg0, 6, b"MANTASUI", b"MANTA ON SUI", b"Manta Sui is a meme coin created for the Sui fam collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Make_a_cartoon_image_of_the_stingray_cartoon_token_logo_in_a_cute_like_baby_blue_color_no_word_fd1f376e13.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

