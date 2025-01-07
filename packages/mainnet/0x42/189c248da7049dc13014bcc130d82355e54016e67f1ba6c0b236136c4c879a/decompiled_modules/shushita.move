module 0x42189c248da7049dc13014bcc130d82355e54016e67f1ba6c0b236136c4c879a::shushita {
    struct SHUSHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUSHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUSHITA>(arg0, 8, b"Shushita", b"Shushi", b"Shushi for shushita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/users/3236761/screenshots/9130476/media/e808133467ef8e958c8081a43004923f.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHUSHITA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUSHITA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUSHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

