module 0x1db0124b422c39cfb83d8e43915b357f7dbf697f1f9288d81044d37c6a9b0521::shiko {
    struct SHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIKO>(arg0, 6, b"SHIKO", b"Shiba Aiko", b"Calm on the outside, moon-bound on the inside. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8644d73a0d19eedcd72e71424bdf0921_251bd5d4f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

