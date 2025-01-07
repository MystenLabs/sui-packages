module 0xd705882d67415b7166cf24b37c5432c08d3342d26e8e4f9752ca244a25b4e194::shrek {
    struct SHREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREK>(arg0, 6, b"SHREK", b"Blue Shrek", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5fa24e52b57b7b6_upscaled_b31c540090.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

