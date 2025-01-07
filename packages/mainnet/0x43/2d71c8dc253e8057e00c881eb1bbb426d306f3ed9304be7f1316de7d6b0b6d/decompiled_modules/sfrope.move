module 0x432d71c8dc253e8057e00c881eb1bbb426d306f3ed9304be7f1316de7d6b0b6d::sfrope {
    struct SFROPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROPE>(arg0, 6, b"SFROPE", b"SUI FROPE", b"Frope is one of the world's most famous frogs. His smiling face originated in a comic book series in 2004 and has since appeared in countless memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3876_bf2decb174.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFROPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

