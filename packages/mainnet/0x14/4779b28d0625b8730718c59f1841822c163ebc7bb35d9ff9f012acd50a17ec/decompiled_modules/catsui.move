module 0x144779b28d0625b8730718c59f1841822c163ebc7bb35d9ff9f012acd50a17ec::catsui {
    struct CATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUI>(arg0, 6, b"CATSUI", b"CatSui", b"CatSui is a fun and innovative memecoin created on the Sui blockchain, focused on bringing the community together with lightness and creativity. Inspired by the spirit of camaraderie and meme culture, SuiCat combines the growth potential of crypto assets with the charm of an endearing feline character. Leveraging the security and scalability of the Sui network, the SuiCat token goes beyond a simple meme, seeking to create a vibrant and engaged ecosystem. Join the fun and be part of the meme revolution with SuiCat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catsui_3c5e5d15b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

