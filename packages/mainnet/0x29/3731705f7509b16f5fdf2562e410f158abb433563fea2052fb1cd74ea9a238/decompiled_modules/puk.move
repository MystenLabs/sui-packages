module 0x293731705f7509b16f5fdf2562e410f158abb433563fea2052fb1cd74ea9a238::puk {
    struct PUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUK>(arg0, 6, b"PUK", b"Puk On Sui", b"In a quiet antique shop, a new doll with a quirky, painted smile and no clothes suddenly blinked to life. With a flash and a click, he discovered a Phone and found himself oddly drawn to it. Calling himself Puk the doll set off into the wide world, snapping selfies at every stop: dangling from the Eiffel Tower, striking a pose on the edge of the Grand Canyon, and even photobombing a wedding in Tokyo. Everywhere he went, Puk left a little photo behind, and legend has it that if you find one of his selfies, the dolls magic will bring you luckjust as it did for him on his endless adventure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052965_7584c5fee4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

