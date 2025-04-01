module 0xa56bc312eb5e04f4e0e62c83cc1e0c7d9a14d9e276f88c2bec9a6c71186054da::whsui {
    struct WHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHSUI>(arg0, 9, b"whSUI", b"WheatSui", x"546865206661726d2d746f2d6261672073686974636f696e2074686174e28099732061637475616c6c792020676c7574656e2d667265652e0a0af09f9a9c204d756c74692d636861696e2c207a65726f2d7969656c64206661726d696e672e0af09f94a5205072652d6d696e656420666f7220e28098636f6d6d756e697479207669626573e280992e0af09fa49d2044414f2d676f7665726e65642028627574206c6574e2809973206265207265616c2c20746865206465767320636f6e74726f6c2065766572797468696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bulltrend-images.s3.amazonaws.com/images/f043f24b1fabb4685e1df0cf3bd0d7ac7fffca6696372015b3eebec40beee50c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHSUI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHSUI>>(v2, @0x57b67a78dc80687b9b51a8d82c5528b6a339f1f504be2c473aafd42309f48cfd);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

