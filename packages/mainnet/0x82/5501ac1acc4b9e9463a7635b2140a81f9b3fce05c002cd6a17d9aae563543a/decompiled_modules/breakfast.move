module 0x825501ac1acc4b9e9463a7635b2140a81f9b3fce05c002cd6a17d9aae563543a::breakfast {
    struct BREAKFAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAKFAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAKFAST>(arg0, 6, b"Breakfast", b"Happy breakfast", x"54686520636f696e2064656469636174656420746f20616c6c207468696e677320627265616b6661737420616e6420746f20616c6c20627265616b66617374206c6f766572732e200a0a446f20796f75206c696b6520627265616b666173743f20426f792049207375726520646f2e2053656e6420627265616b6661737420746f20746865206d6f6f6e210a0a4a75737420612073696d706c6520616e642066756e20636f6d6d756e697479206261736564206f6e207468652062657374206d65616c206f66207468652064617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bacon_egg_and_toast_cartoon_breakfast_characters_clip_art_vector_45cefb3a14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAKFAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAKFAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

