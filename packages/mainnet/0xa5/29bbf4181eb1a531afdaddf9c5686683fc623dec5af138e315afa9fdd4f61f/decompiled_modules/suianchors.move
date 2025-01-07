module 0xa529bbf4181eb1a531afdaddf9c5686683fc623dec5af138e315afa9fdd4f61f::suianchors {
    struct SUIANCHORS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANCHORS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANCHORS>(arg0, 6, b"SUIANCHORS", b"anchors", x"446973636f7665720a736d6172740a616e63686f72696e670a4e6f206d6f726520616e63686f7220616e78696574792e0a536c656570206c696b6520612062616279207769746820566973696f6e416e63686f722053", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_27_99c1282268_667730fbca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANCHORS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIANCHORS>>(v1);
    }

    // decompiled from Move bytecode v6
}

