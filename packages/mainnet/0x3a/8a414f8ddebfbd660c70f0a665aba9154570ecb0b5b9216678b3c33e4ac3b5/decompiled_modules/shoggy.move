module 0x3a8a414f8ddebfbd660c70f0a665aba9154570ecb0b5b9216678b3c33e4ac3b5::shoggy {
    struct SHOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOGGY>(arg0, 6, b"SHOGGY", b"Shoggoth", b"The Shoggoth, a character from a science fiction story, captures the essential weirdness of the A.I. moment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shoggy2_608b7492e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

