module 0x7ccfc3098d3eb18f137d9ee66a86c5c9bb81ac5f509074881f166af9781c2113::chiikawa {
    struct CHIIKAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIIKAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIIKAWA>(arg0, 6, b"Chiikawa", b"ChiikawaSUI", b"The work mainly depicts the daily life of a group of unique little animals, the \"Cute Tribe\", and uses simple multi-frame comics to present different stories. The world of this game has rich and diverse natural landscapes, such as forests, grasslands, rivers, etc. There is a lot of food distributed in the environment, and there are also places where food flows out or where plants grow naturally. At the same time, there are houses and shops in the world, as well as a monetary economy and the Internet. This is a very civilized world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/message_Image_1728753652207_e27c21d3fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIIKAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIIKAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

