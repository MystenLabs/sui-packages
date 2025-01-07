module 0x8f4771cafedb1281ddd23f61a0ac25730f6104373c31716e8dfb5dfa79b5ab42::lola {
    struct LOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLA>(arg0, 6, b"LOLA", b"LOLA BY MATT FURIE | $LOLA", x"4c4f4c4120697320612062656c6f76656420636174206279204d6174742046757269652e20546865206d6f737420696d707265737369766520636861726163746572206f662068697320636f6d69632065646974696f6e732120536865206c6f76657320746f207075727220616e64207368617270656e2068657220636c617773206f6e206a65657473210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOLA_2c33122b95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

