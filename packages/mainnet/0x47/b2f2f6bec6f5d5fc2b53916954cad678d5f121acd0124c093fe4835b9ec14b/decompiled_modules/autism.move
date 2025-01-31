module 0x47b2f2f6bec6f5d5fc2b53916954cad678d5f121acd0124c093fe4835b9ec14b::autism {
    struct AUTISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTISM>(arg0, 6, b"Autism", b"Autism Coin", b"If this does not rip Im going to be sad and playing with my model train set all alone tonight ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1785_4453a81acf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

