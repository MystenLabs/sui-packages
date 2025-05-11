module 0xb468edaa82a9991aec795eaf730bec99cf99502a761a28007f6630ab8a32b7ab::shiro {
    struct SHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIRO>(arg0, 6, b"SHIRO", b"Shiro", b"Shiro Neko, On a mission to fulfill the cat prophecy. Join the #SHIROARMY and be a part of the communnity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068757_87009fe6ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

