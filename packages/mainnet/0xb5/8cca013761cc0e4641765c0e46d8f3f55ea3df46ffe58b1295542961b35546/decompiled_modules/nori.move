module 0xb58cca013761cc0e4641765c0e46d8f3f55ea3df46ffe58b1295542961b35546::nori {
    struct NORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORI>(arg0, 6, b"NORI", b"NoriTheDog", b"Hey, look at me, I'm Nori. Don't make me angry!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2270_removebg_preview_01_b10304d92d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

