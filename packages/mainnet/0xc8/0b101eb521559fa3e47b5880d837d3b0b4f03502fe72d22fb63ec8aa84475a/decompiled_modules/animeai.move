module 0xc80b101eb521559fa3e47b5880d837d3b0b4f03502fe72d22fb63ec8aa84475a::animeai {
    struct ANIMEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIMEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIMEAI>(arg0, 6, b"ANIMEAI", b"ANIME AI", b"Anime made with the help of AI and community let's build together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7793_6ecb3cb3f9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIMEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANIMEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

