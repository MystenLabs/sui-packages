module 0xb32d06d19130c9bd241d273689cfb858988a8207b402761d51d671afd1e6a327::chitu {
    struct CHITU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHITU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHITU>(arg0, 2, b"Chitu", b"Chinos Turtle", b"Chitu Token: The Fun Meme Coin  Lop Token is a vibrant and community-driven meme coin designed to bring joy and laughter to the crypto space. With a playful and engaging brand, Lop aims to create a lighthearted atmosphere while fostering a strong community of supporters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdvfaLQyACa-Fk-H4VdNNdYw2V_cf8yI3j7doDkvyycFyRO2XoXVTmPFSoDEVF9Pa3bK4&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHITU>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHITU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHITU>>(v1);
    }

    // decompiled from Move bytecode v6
}

