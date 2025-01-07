module 0xe4cc8e77f52739355cecde983f739d866e119c242c6a0263a32023f477733b4f::shiroinu {
    struct SHIROINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIROINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIROINU>(arg0, 6, b"SHIROINU", b"SHIRO INU", b"WHITE DOG OF SUI $SHIROINU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_141133_689_659b6e3bd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIROINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIROINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

