module 0x2d7af49e6d9f9dd8ceb2a25b672ed3466120b67e0acf9aa3c71b9b4e61ee4a7f::baa {
    struct BAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAA>(arg0, 6, b"BAA", b"Baa the Happy Cow", b"Description: Baa the Happy Cow is a unique and playful digital token that embodies joy, creativity, and a sense of whimsical fun. Inspired by a cheerful cow with a sheep's \"baa,\" this token represents the spirit of freedom, blending different elements to create something entirely new and delightful.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/thumb_back/fw800/background/20231225/pngtree-black-and-white-cartoon-meme-template-with-comic-cows-image_15510131.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BAA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

