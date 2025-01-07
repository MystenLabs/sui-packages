module 0xedb0828b920ec2e5e2242fbdc27480906c485d1d1c1ee0b281f2c00d5589e5d4::wowo {
    struct WOWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWO>(arg0, 6, b"Wowo", b"WowoSui", b"In the bustling world of cryptocurrency, where innovation and memes intertwine, a new star was born. Its name? WOWO, a meme coin inspired by the infamous shocked Pepe meme, a symbol of surprise and amusement in the vast landscape of internet culture. This is the story of WOWO,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_16_19_15_09_15e59cd26a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

