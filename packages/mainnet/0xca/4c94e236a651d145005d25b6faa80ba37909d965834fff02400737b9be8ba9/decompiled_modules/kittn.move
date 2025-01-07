module 0xca4c94e236a651d145005d25b6faa80ba37909d965834fff02400737b9be8ba9::kittn {
    struct KITTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTN>(arg0, 6, b"KITTN", b"KITTEN ON SUI", x"42616279205a65656b20436f696e210a546865206f6666696369616c206b697474656e206f662053756920244b495454454e206361727269657320746865205a65656b206c696e6561676520666f722067656e65726174696f6e7320746f20636f6d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x9d86578f4b935bed8398353c89bf0fca987dcef2_d3c0269015.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

