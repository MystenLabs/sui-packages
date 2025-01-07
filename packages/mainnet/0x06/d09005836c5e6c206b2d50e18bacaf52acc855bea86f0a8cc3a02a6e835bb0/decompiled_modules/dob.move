module 0x6d09005836c5e6c206b2d50e18bacaf52acc855bea86f0a8cc3a02a6e835bb0::dob {
    struct DOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOB>(arg0, 6, b"DOB", b"dogbite", b"If you don't buy dogbite ($DOB), the dog will bite you!  This isn't just any meme coin dogbite is the fierce leader of meme coins, and it's hungry for more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Telegram_Image_ac9fea8351.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

