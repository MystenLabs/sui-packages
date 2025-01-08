module 0xced7f1830b17d45a77544be84f40ee9f08e70b773ce2808ea7f581e4eeaa9edd::openagi {
    struct OPENAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPENAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPENAGI>(arg0, 6, b"openAGI", b"OpenAGI", b"An open-source-framework for building AGI agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Open_AGI_small_a0cd43290d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPENAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPENAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

